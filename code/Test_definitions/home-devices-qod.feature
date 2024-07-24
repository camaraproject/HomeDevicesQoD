Feature: CAMARA Home Devices QoD API, v0.4.0
    # Input to be provided by the implementation to the tester
    #
    # Implementation indications:
    # * the maximum quantity of devices with non-default QoS behaviour
    # * RSSI allowed threshold
    # * maximum QoS (service class value) allowed
    # * home network occupancy threshold
    # * supported router interfaces and frequency bands in WiFi interface
    #
    # Testing assets:
    # * A home device connected to the user home network identified by its IPv4 address
    # * A home device connected to a specific frequency band that does not match to the required interface
    # * A home device that does not support the required interface
    # * A home device with RSSI is below allowed threshold
    # * A user home network with the maximum quantity of devices with non-default QoS behaviour
    # * A user home network with the occupancy above the allowed threshold
    # * A user home network with the router offline
    #
    # References to OAS spec schemas refer to schemas specifies in home_devices_qod.yaml, version 0.4.0

    Background: Common setQos setup
        Given an environment at "apiRoot"
        And the resource "home-devices-qod/v0.4/qos"
        And the header "Content-Type" is set to "application/json"
        And the header "Authorization" is set to a valid access token
        And the header "x-correlator" is set to a UUID value
        And the request body is set by default to a request body compliant with the schema

    # Happy path scenarios

    @setQos_01_set_service_class_success
    Scenario Outline: Validate success response updating service class to "<serviceClass>"
        Given the access token identifies the user and the user home network
        And the request body property "$.serviceClass" is set to "<serviceClass>"
        And the request body property "$.ipAddress" is set to the IP address of the device connected to the user home network
        When the request "setQos" is sent
        Then the response status code is 204
        And the response header "x-correlator" has same value as the request header "x-correlator"

        Examples:
            | serviceClass          |
            | real_time_interactive |
            | multimedia_streaming  |
            | broadcast_video       |
            | low_latency_data      |
            | high_throughput_data  |
            | low_priority_data     |

    @setQos_02_restore_default_service_class_success
    Scenario Outline: Validate success response restoring service class to default value
        Given the access token identifies the user and the user home network
        And the request body property "$.serviceClass" is set to "standard"
        And the request body property "$.ipAddress" is set to the IP address of the device connected to the user home network
        And the device service class was previously set to "<serviceClass>"
        When the request "setQos" is sent
        Then the response status code is 204
        And the response header "x-correlator" has same value as the request header "x-correlator"

        Examples:
            | serviceClass          |
            | real_time_interactive |
            | multimedia_streaming  |
            | broadcast_video       |
            | low_latency_data      |
            | high_throughput_data  |
            | low_priority_data     |

    # Generic errors

    @setQos_03_missing_required_property
    Scenario Outline: Error response for missing required property in request body
        Given the access token identifies the user and the user home network
        And the request body property "<required_property>" is not included
        When the request "setQos" is sent
        Then the response status code is 400
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

        Examples:
            | required_property |
            | $.serviceClass    |
            | $.ipAddress       |

    @setQos_04_invalid_ip_address_format
    Scenario: Error 400 when the IP address format is not IPv4
        Given the access token identifies the user and the user home network
        And the request body property "$.ipAddress" is not set to a valid IPv4 address
        When the request "setQos" is sent
        Then the response status code is 400
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text
    
    @setQos_05_invalid_service_class
    Scenario: Error 400 when service class is none of the allowed values
        Given the access token identifies the user and the user home network
        And the request body property "$.serviceClass" is not set to any of the allowed values
        When the request "setQos" is sent
        Then the response status code is 400
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

    @setQos_06_expired_access_token
    Scenario: Error response for expired access token
        Given an expired access token
        And the request body is set to a valid request body
        When the request "setQos" is sent
        Then the response status code is 401
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 401
        And the response property "$.code" is "UNAUTHENTICATED"
        And the response property "$.message" contains a user friendly text

    @setQos_07_invalid_access_token
    Scenario: Error response for invalid access token
        Given an invalid access token
        And the request body is set to a valid request body
        When the request "setQos" is sent
        Then the response status code is 401
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 401
        And the response property "$.code" is "UNAUTHENTICATED"
        And the response property "$.message" contains a user friendly text

    @setQos_08_missing_authorization_header
    Scenario: Error response for no header "Authorization"
        Given the header "Authorization" is not sent
        And the request body is set to a valid request body
        When the request "setQos" is sent
        Then the response status code is 401
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 401
        And the response property "$.code" is "UNAUTHENTICATED"
        And the response property "$.message" contains a user friendly text

    # API Specific Errors

    @setQos_09_user_home_network_not_deducted_from_access_token
    Scenario: Error 403 when user home network cannot be deducted from access token
        Given the access token does not contain user home network identifier
        And the request body is set to a valid request body
        When the request "setQos" is sent
        Then the response status code is 403
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 403
        And the response property "$.code" is "HOME_DEVICES_QOD.INVALID_TOKEN_CONTEXT"
        And the response property "$.message" contains a user friendly text

    @setQos_10_no_device_found
    Scenario: Error 404 when there is no connected device matching with input criteria
        Given the access token identifies the user and the user home network
        And the request body property "$.ipAddress" is set to a non-existent IP address for any device connected to the user home network
        When the request "setQos" is sent
        Then the response status code is 404
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 404
        And the response property "$.code" is "HOME_DEVICES_QOD.NO_DEVICE_MATCH"
        And the response property "$.message" contains a user friendly text

    @setQos_11_devices_quantity_exceeded
    Scenario: Error 409 when the request exceeds the maximum quantity of devices with non-default QoS behaviour
        Given a user with the maximum quantity of devices with non-default QoS behaviour
        And the access token identifies the user and the user home network
        And the request body property "$.serviceClass" is set to a value different from "standard"
        And the request body property "$.ipAddress" is set to the IP address of the device connected to the user home network
        When the request "setQos" is sent
        Then the response status code is 409
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 409
        And the response property "$.code" is "HOME_DEVICES_QOD.TOO_MANY_DEVICES"
        And the response property "$.message" contains a user friendly text

    @setQos_12_rssi_below_threshold
    Scenario: Error 409 when RSSI from device is below allowed threshold
        Given the access token identifies the user and the user home network
        And the request body property "$.ipAddress" is set to the IP address of the device connected to the user home network
        And the RSSI value from device is less than threshold
        When the request "setQos" is sent
        Then the response status code is 409
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 409
        And the response property "$.code" is "HOME_DEVICES_QOD.RSSI_BELOW_THRESHOLD"
        And the response property "$.message" contains a user friendly text

    @setQos_13_qos_higher_than_allowed
    Scenario: Error 409 when requested QoS is higher than the maximum QoS allowed
        Given the access token identifies the user and the user home network
        And the request body property "$.serviceClass" is set to a value higher than the maximum QoS allowed for the user home network
        And the request body property "$.ipAddress" is set to the IP address of the device connected to the user home network
        And the home user network has a QoS limit allowed
        When the request "setQos" is sent
        Then the response status code is 409
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 409
        And the response property "$.code" is "HOME_DEVICES_QOD.QOS_TOO_HIGH"
        And the response property "$.message" contains a user friendly text

    @setQos_14_occupancy_higher_than_allowed
    Scenario: Error 409 when the occupancy is above the allowed threshold
        Given the access token identifies the user and the user home network
        And the request body is set to a valid request body
        And the user home network occupancy is above the threshold
        When the request "setQos" is sent
        Then the response status code is 409
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 409
        And the response property "$.code" is "HOME_DEVICES_QOD.OCCUPANCY_ABOVE_THRESHOLD"
        And the response property "$.message" contains a user friendly text

    @setQos_15_InterfaceNotConnected
    Scenario: Error 409 when the device is not connected to the required interface
        Given a user with a device connected to a specific frequency band that does not match to the required interface
        And the access token identifies the user and the user home network
        And the request body property "$.ipAddress" is set to the IP address of the device connected to the user home network
        When the request "setQos" is sent
        Then the response status code is 409
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 409
        And the response property "$.code" is "HOME_DEVICES_QOD.NOT_CONNECTED_TO_REQUIRED_INTERFACE"
        And the response property "$.message" contains a user friendly text

    @setQos_16_interface_not_supported
    Scenario: Error 409 when the device does not support required interface
        Given a user with a device that does not support the required interface
        And the access token identifies the user and the user home network
        And the request body property "$.ipAddress" is set to the IP address of the device connected to the user home network
        When the request "setQos" is sent
        Then the response status code is 409
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 409
        And the response property "$.code" is "HOME_DEVICES_QOD.NOT_SUPPORTED_REQUIRED_INTERFACE"
        And the response property "$.message" contains a user friendly text

    @setQos_17_default_value_in_device
    Scenario: Error 409 when the device QoS is already set to default value
        Given the access token identifies the user and the user home network
        And the device service class is set to "standard"
        And the request body property "$.serviceClass" is set to "standard"
        And the request body property "$.ipAddress" is set to the IP address of the device connected to the user home network
        When the request "setQos" is sent
        Then the response status code is 409
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 409
        And the response property "$.code" is "HOME_DEVICES_QOD.QOS_ALREADY_SET_TO_DEFAULT"
        And the response property "$.message" contains a user friendly text

    @setQos_18_service_unavailable
    Scenario: Error 503 when the router is offline
        Given the access token identifies the user and the user home network
        And the request body is set to a valid request body
        And the router is offline
        When the request "setQos" is sent
        Then the response status code is 503
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 503
        And the response property "$.code" is "HOME_DEVICES_QOD.ROUTER_OFFLINE"
        And the response property "$.message" contains a user friendly text
