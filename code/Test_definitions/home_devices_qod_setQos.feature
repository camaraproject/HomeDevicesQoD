#
# Revision: 0

Feature: Home Devices QoD 0.2.0 - setQos

    Set the desired QoS behaviour for the traffic corresponding to the user home device matching the input criteria. **QoS behaviour is determined by the service class provided by the API Client. Setting `standard` service class restores default traffic treatment for the target home device.**

- The operation is executed for the user whose `sub` is in the access token used to call this endpoint, and for the home network also deducted from the information included in the access token.
- The target user device is identified by the internal IP address of that device in the home network.
- In case there is no device matching the input criteria, the operation returns a 404 error.

    Background: An environment where Operator's API GW exposes setQos
        Given an environment with Operator's API GW
        And the endpoint "home-devices-qod/v0/qos"
        And the method "put"
        And the request body is set to:
            """
            {
              "serviceClass": "real_time_interactive",
              "ipAddress": "192.168.1.27"
            }
            """
        And the header "x-correlator" is set to "[UUIDv4]"


    # Common errors


    @setQos_E10.01
    Scenario: Error response for expired access token
        Given I want to test "setQos"
        And an expired access_token
        When I request "setQos"
        Then the response status code is "401"
        And the API returns the error code "UNAUTHENTICATED"
        And the API returns a human readable error message


    @setQos_E10.02
    Scenario: Error response for invalid access token
        Given I want to test "setQos"
        And an invalid access_token
        When I request "setQos"
        Then the response status code is "401"
        And the API returns the error code "UNAUTHENTICATED"
        And the API returns a human readable error message


    @setQos_E10.03
    Scenario: Error response for no header "Authorization"
        Given I want to test "setQos"
        And the header "Authorization" is not sent
        When I request "setQos"
        Then the response status code is "401"
        And the API returns the error code "UNAUTHENTICATED"
        And the API returns a human readable error message


    @setQos_E13.03
    Scenario Outline: Error response for missing required property in request body
        Given I want to test "setQos"
        And a valid access_token
        And the request body at "<request_body>"
        When I request "setQos"
        Then the response status code is "400"
        And the API returns the error code "INVALID_ARGUMENT"
        And the API returns a human readable error message

        Examples:
            | request_body                                         |
            | ./data/setQos_request_data_missing_serviceClass.json |
            | ./data/setQos_request_data_missing_ipAddress.json    |


    # API Specific Errors


    @setQos_E19.01_InvalidIPAddressFormat
    Scenario: Error 400 when the IP address format is not IPv4
        Given I want to test "setQos"
        And a valid access_token
        And the access token identifies the user and the user home network
        And the request body is set to:
            """
            {
              "serviceClass": "real_time_interactive",
              "ipAddress": "invalid_ipAddress"
            }
            """
        When I request "setQos"
        Then the response status code is "400"
        And the API returns the error code "INVALID_ARGUMENT"
        And the API returns a human readable error message


    @setQos_E19.02_InvalidServiceClass
    Scenario: Error 400 when service class is none of the allowed values
        Given I want to test "setQos"
        And a valid access_token
        And the access token identifies the user and the user home network
        And the variable "[CONTEXT: ipAddress]" is set to the device IP address connected in the user home network
        And the request body is set to:
            """
            {
              "serviceClass": "invalid_service_class",
              "ipAddress": "[CONTEXT: ipAddress]"
            }
            """
        When I request "setQos"
        Then the response status code is "400"
        And the API returns the error code "INVALID_ARGUMENT"
        And the API returns a human readable error message


    @setQos_E19.03_UserHomeNetworkNotDeductedFromAccessToken
    Scenario: Error 403 when user home network cannot be deducted from access token
        Given I want to test "setQos"
        And a valid access_token
        And the access token does not contain user home network identifier
        And the request body is set to:
            """
            {
              "serviceClass": "real_time_interactive",
              "ipAddress": "192.168.1.27"
            }
            """
        When I request "setQos"
        Then the response status code is "403"
        And the API returns the error code "HOME_DEVICES_QOD.INVALID_TOKEN_CONTEXT"
        And the API returns a human readable error message


    @setQos_E19.04_NoDeviceFound
    Scenario: Error 404 when there is no connected device matching with input criteria
        Given I want to test "setQos"
        And a valid access_token
        And the access token identifies the user and the user home network
        And the variable "[CONTEXT: ipAddress]" is set to a non-existent IP address for any device connected to the user home network
        And the request body is set to:
            """
            {
              "serviceClass": "real_time_interactive",
              "ipAddress": "[CONTEXT: ipAddress]"
            }
            """
        When I request "setQos"
        Then the response status code is "404"
        And the API returns the error code "HOME_DEVICES_QOD.NO_DEVICE_MATCH"
        And the API returns a human readable error message


    @setQos_E19.05_DevicesQuantityExceeded
    Scenario: Error 409 when the request exceeds the maximum quantity of devices with non-default QoS behaviour
        Given I want to test "setQos" for a user with the maximum quantity of devices with non-default QoS behaviour
        And a valid access_token
        And the access token identifies the user and the user home network
        And the variable "[CONTEXT: ipAddress]" is set to the device IP address connected in the user home network
        And the variable "[CONTEXT: serviceClass]" is set to a value different from "standard"
        And the request body is set to:
            """
            {
              "serviceClass": "[CONTEXT: serviceClass]",
              "ipAddress": "[CONTEXT: ipAddress]"
            }
            """
        When I request "setQos"
        Then the response status code is "409"
        And the API returns the error code "HOME_DEVICES_QOD.TOO_MANY_DEVICES"
        And the API returns a human readable error message


    @setQos_E19.06_RSSIBelowThreshold
    Scenario: Error 409 when RSSI from device is below allowed threshold
        Given I want to test "setQos"
        And a valid access_token
        And the access token identifies the user and the user home network
        And the variable "[CONTEXT: ipAddress]" is set to the device IP address connected in the user home network
        And the RSSI value from device is less than threshold
        And the request body is set to:
            """
            {
              "serviceClass": "real_time_interactive",
              "ipAddress": "[CONTEXT: ipAddress]"
            }
            """
        When I request "setQos"
        Then the response status code is "409"
        And the API returns the error code "HOME_DEVICES_QOD.RSSI_BELOW_THRESHOLD"
        And the API returns a human readable error message


    @setQos_E19.07_QoSHigherThanAllowed
    Scenario: Error 409 when requested QoS is higher than the maximum QoS allowed
        Given I want to test "setQos"
        And a valid access_token
        And the access token identifies the user and the user home network
        And the variable "[CONTEXT: ipAddress]" is set to the device IP address connected in the user home network
        And the home user network has a QoS limit allowed
        And the variable "[CONTEXT: serviceClass]" is set to a value higher than the maximum QoS allowed for the user home network
        And the request body is set to:
            """
            {
              "serviceClass": "[CONTEXT: serviceClass]",
              "ipAddress": "[CONTEXT: ipAddress]"
            }
            """
        When I request "setQos"
        Then the response status code is "409"
        And the API returns the error code "HOME_DEVICES_QOD.QOS_TOO_HIGH"
        And the API returns a human readable error message


    @setQos_E19.08_OccupancyHigherThanAllowed
    Scenario: Error 409 when the occupancy is above the allowed threshold
        Given I want to test "setQos"
        And a valid access_token
        And the access token identifies the user and the user home network
        And the variable "[CONTEXT: ipAddress]" is set to the device IP address connected in the user home network
        And the user home network occupancy is above the threshold
        And the request body is set to:
            """
            {
              "serviceClass": "real_time_interactive",
              "ipAddress": "[CONTEXT: ipAddress]"
            }
            """
        When I request "setQos"
        Then the response status code is "409"
        And the API returns the error code "HOME_DEVICES_QOD.OCCUPANCY_ABOVE_THRESHOLD"
        And the API returns a human readable error message


    @setQos_E19.09_InterfaceNotConnected
    Scenario: Error 409 when the device is not connected to the required interface
        Given I want to test "setQos" for a user with a device connected to a specific frequency band
        And a valid access_token
        And the access token identifies the user and the user home network
        And the variable "[CONTEXT: ipAddress]" is set to the device IP address connected in the user home network
        And the device is not connected to the required interface
        And the request body is set to:
            """
            {
              "serviceClass": "real_time_interactive",
              "ipAddress": "[CONTEXT: ipAddress]"
            }
            """
        When I request "setQos"
        Then the response status code is "409"
        And the API returns the error code "HOME_DEVICES_QOD.NOT_CONNECTED_TO_REQUIRED_INTERFACE"
        And the API returns a human readable error message


    @setQos_E19.10_InterfaceNotSupported
    Scenario: Error 409 when the device does not support required interface
        Given I want to test "setQos" for a user with a device connected to a specific frequency band
        And a valid access_token
        And the access token identifies the user and the user home network
        And the variable "[CONTEXT: ipAddress]" is set to the device IP address connected in the user home network
        And the device does not support the required interface
        And the request body is set to:
            """
            {
              "serviceClass": "real_time_interactive",
              "ipAddress": "[CONTEXT: ipAddress]"
            }
            """
        When I request "setQos"
        Then the response status code is "409"
        And the API returns the error code "HOME_DEVICES_QOD.NOT_SUPPORTED_REQUIRED_INTERFACE"
        And the API returns a human readable error message


    @setQos_E19.11_DefaultValueInDevice
    Scenario: Error 409 when the device QoS is already set to default value
        Given I want to test "setQos"
        And a valid access_token
        And the access token identifies the user and the user home network
        And the variable "[CONTEXT: ipAddress]" is set to the device IP address connected in the user home network
        And the device service class is set to "standard"
        And the request body is set to:
            """
            {
              "serviceClass": "standard",
              "ipAddress": "[CONTEXT: ipAddress]"
            }
            """
        When I request "setQos"
        Then the response status code is "409"
        And the API returns the error code "HOME_DEVICES_QOD.QOS_ALREADY_SET_TO_DEFAULT"
        And the API returns a human readable error message


    @setQos_E19.12_ServiceUnavailable
    Scenario: Error 503 when the router is offline
        Given I want to test "setQos"
        And a valid access_token
        And the access token identifies the user and the user home network
        And the variable "[CONTEXT: ipAddress]" is set to the device IP address connected in the user home network
        And the router is offline
        And the request body is set to:
            """
            {
              "serviceClass": "real_time_interactive",
              "ipAddress": "[CONTEXT: ipAddress]"
            }
            """
        When I request "setQos"
        Then the response status code is "503"
        And the API returns the error code "HOME_DEVICES_QOD.ROUTER_OFFLINE"
        And the API returns a human readable error message


    # API Specific validations


    @setQos_30.01_ValidateSuccessResponse
    Scenario Outline: Validate success response updating service class to "<serviceClass>"
        Given I want to test "setQos"
        And a valid access_token
        And the access token identifies the user and the user home network
        And the variable "[CONTEXT: ipAddress]" is set to the device IP address connected in the user home network
        And the variable "[CONTEXT: serviceClass]" is set to "<serviceClass>"
        And the request body is set to:
            """
            {
              "serviceClass": "[CONTEXT: serviceClass]",
              "ipAddress": "[CONTEXT: ipAddress]"
            }
            """
        When I request "setQos"
        Then the response status code is "204"

        Examples:
            | serviceClass          |
            | real_time_interactive |
            | multimedia_streaming  |
            | broadcast_video       |
            | low_latency_data      |
            | high_throughput_data  |
            | low_priority_data     |


    @setQos_30.02_ValidateCorrelatorHeader
    Scenario Outline: Validate having same x-correlator header value in response
        Given I want to test "setQos"
        And a valid access_token
        And the access token identifies the user and the user home network
        And the header "x-correlator" is set to "<value>"
        And the variable "[CONTEXT: ipAddress]" is set to the device IP address connected in the user home network
        And the request body is set to:
            """
            {
              "serviceClass": "real_time_interactive",
              "ipAddress": "[CONTEXT: ipAddress]"
            }
            """
        When I request "setQos"
        Then the response status code is "204"
        And the value of header "x-correlator" in response is the one set in request

        Examples:
            | value              |
            | [UUIDv4]           |
            | [RANDOM: STR(64)]  |
            | string with spaces |
            | "quoted string"    |


    @setQos_30.03_ValidateRestoreDevice
    Scenario Outline: Validate success response updating service class to default value
        Given I want to test "setQos"
        And a valid access_token
        And the access token identifies the user and the user home network
        And the variable "[CONTEXT: ipAddress]" is set to the device IP address connected in the user home network
        And the device service class was previously set to "<serviceClass>"
        And the request body is set to:
            """
            {
              "serviceClass": "standard",
              "ipAddress": "[CONTEXT: ipAddress]"
            }
            """
        When I request "setQos"
        Then the response status code is "204"

        Examples:
            | serviceClass          |
            | real_time_interactive |
            | multimedia_streaming  |
            | broadcast_video       |
            | low_latency_data      |
            | high_throughput_data  |
            | low_priority_data     |

