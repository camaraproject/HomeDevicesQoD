- [1. Overview](#1-overview)
  - [1.1. Introduction](#11-introduction)
  - [1.2. Quick Start](#12-quick-start)
- [2. Authentication and/or Authorization](#2-authentication-andor-authorization)
- [3. Documentation](#3-documentation)
  - [3.1. Details](#31-details)
  - [3.2. Endpoint definitions](#32-endpoint-definitions)
      - [Home Devices QoD Operations](#home-devices-qod-operations)
  - [3.3. Errors](#33-errors)
  - [3.4. Policies](#34-policies)
  - [3.5. Code snippets](#35-code-snippets)
  - [3.6. FAQs](#36-faqs)
  - [3.7. Terms](#37-terms)
  - [3.8. Release Notes](#38-release-notes)
  - [3.9. Pricing](#39-pricing)
- [4. References](#4-references)

<br>

# 1. Overview

Home Devices QoD API provides a programmable interface for developers and other users (capabilities consumers) to implement traffic management policies on top of Operator’s internet connectivity services. More specifically, the API allows to choose on demand the traffic profile (DSCP mark) for downstream IP traffic within user home network for a given home device.

Relevant Definitions and concepts:
- *Home Device*: user devices connected to the user home network.
- *DSCP*: Differentiated Services (DiffServ) Code Point. DiffServ is a simple and scalable mechanism for classifying and managing network traffic and providing quality of service (QoS) on IP networks. The DSCP value will be used to classify the traffic of the target home device in order to be treated accordingly.

## 1.1. Introduction

It may be useful for application developers to request on demand specific traffic profiles (DSCP marks) to be configured at end-user’s residential Home WiFi Access Point in order to ensure the required QoE (Quality of Experience) for those services/applications running on an specific home device.

For example, the QoS-on-demand (QoD) control capability could be useful in scenarios such as:

- A user using head-mounted display device for VR/AR applications. VR/AR applications require high bandwidth for the big amount of data to be streamed.
- A user using VoIP application in a home device. Lower latency improves call quality or avoids dropped calls.

Generally speaking, QoS on demand may improve QoE for real time services like Videocomms, Cloud Gaming and Virtual Reality. E.g.

![Videocomms DSCP usage example](./resources/videocomm_dscp_example.png)

> API scope:
> 
> - traffic profile (DSCP mark) is applied **only within user home network** (i.e. between the device and the home router)
> - traffic profile **only applies to downstream IP traffic** (i.e. from home router towards the target device)
> - traffic profile **only applies to home devices using WiFi access** (i.e. home router WiFi interface)

## 1.2. Quick Start

Home Devices QoD API v0.1.0 exposes only one endpoint, which can be used to set the desired DSCP value for the traffic corresponding to the user device matching the input criteria. Device traffic will be classified and treated accordingly.

To do so, the API client has to pass the following parameters in request body:

1. `dscp` - DSCP information for QoS (DSCP mark requested) 
2. `ip_address` - Internal IP address of the connected target device.  

Sample API invocation is presented in section [3.5. Code snippets](#35-code-snippets).

<br>

# 2. Authentication and/or Authorization

OAuth 2.0 3-legged Access Tokens must be used by API clients to invoke this API with dedicated scope. API client must authenticate in the name of a specific user to use this service [[1]](#1). For doing so it may be done via IP-based authentication (i.e. using device public IP in this case).

The Home Devices QoD API 3-legged access could also be combined with end-user consent management depending on local legal regulation. User consent would be require before any personal information is processed by API clients under a certain purpose.

<br>

# 3. Documentation

## 3.1. Details

> API version: 0.1.0

## 3.2. Endpoint definitions

Following table defines API endpoints of exposed REST based QoD operations for home devices.

| **Endpoint** | **Operation** | **Description** |
| -------- | --------- | ----------- |
| PUT /dscp | **Set the desired DSCP value for a user home device** | Set the desired DSCP value for the traffic corresponding to the user home device matching the input criteria. Setting DSCP value to "CS0" restores default traffic treatment for the target home device.<li>The operation is executed for the user whose `sub` is in the access token used to call this endpoint, and for the home network also deducted from the information included in the access token.<li>The target user device is identified by the internal IP address of that device in the home network.<li>In case there is no device matching the input criteria, the operation returns a 404 error. |

#### Home Devices QoD Operations

| **Set the desired DSCP value for a user home device** |
| --- |
| **HTTP Request** <ul>PUT /dscp</ul> **Query Parameters** <ul>No query parameters are defined.</ul> **Path Parameters** <ul>No path parameter are defined.</ul> **Request Body Parameters** <ul><li>`dscp` **(required)** - *string*.<br>DSCP information for QoS (DSCP mark requested). Possible values are:<br>Enum: "CS0", "CS1", "AF11", "AF12", "AF13", "CS2", "AF21", "AF22", "AF23", "CS3", "AF31", "AF32", "AF33", "CS4", "AF41", "AF42", "AF43", "CS5", "EF", "CS6", "CS7", "MAX_ALLOWED"<li> `ip_address` **(required)** - *string* <br>Pattern: \<ipv4\>  ^(\[01\]?\d\d?\|2\[0-4\]\d\|25\[0-5\])(?:\.(?:\[01\]?\d\d?\|2\[0-4\]\d\|25\[0-5\])){3}?$ <br> Internal IP address of the connected device in the LAN (IPv4 format). E.g. "ip_address": "192.168.1.27".</ul> | 
| **Responses** <ul><li>**204**: New DSCP value passed all validations and was applied.<li>**400**: Problem with the client request.<li>**401**: Authentication problem with the client request.<li>**403**: Client does not have sufficient permission<li>**404**: Resource Not Found.<li>**404**: There is no device matching the input criteria.<li>**409**: Conflict with the current state of the target resource.<li>**409**: DSCP value can't be set. Too many devices.<li>**409**: DSCP value can't be set. RSSI below threshold.<li>**409**: DSCP value can't be set. QoS too high.<li>**409**: DSCP value can't be set. Occupancy above threshold.<li>**409**: DSCP value can't be set. Not connected to required interface.<li>**409**: DSCP value can't be set. Not supported required interface.<li>**409**: DSCP value can't be set. DSCP already set to default.<li>**500**: Server error.<li>**503**: Service unavailable.<li>**503**: The router is offline.<li>**504**: Request time exceeded.</ul> |

## 3.3. Errors

Since Home Devices QoD API is based on REST design principles and blueprints, well defined HTTP status codes and families specified by community are followed [[2]](#2).

Details of HTTP based error/exception codes for the Home Devices QoD API are described in section [3.2.](#32-endpoint-definitions) for each API REST based method. Following table provides an overview of common error names, codes, and messages applicable to Home Devices QoD API.

| No | Error Name | Error Code | Error Message |
| --- | ---------- | ---------- | ------------- |
|1 |400 | INVALID_ARGUMENT |  "Client specified an invalid argument, request body or query param" |
|2 |401 | UNAUTHENTICATED |  "Request not authenticated due to missing, invalid, or expired credentials" |
|3 |403 | PERMISSION_DENIED |  "Client does not have sufficient permissions to perform this action" |
|4 |404 | NOT_FOUND | "A specified resource is not found" |
|5 |404 | HOME_DEVICES_QOD.NO_DEVICE_MATCH | "No connected device found for the input criteria provided." |
|6 |409 | CONFLICT | "Conflict with the current state of the target resource." |
|7 |409 | HOME_DEVICES_QOD.TOO_MANY_DEVICES | "Exceeded the maximum quantity of devices with non-default DSCP value." |
|8 |409 | HOME_DEVICES_QOD.RSSI_BELOW_THRESHOLD | "RSSI from device is below allowed threshold." |
|9 |409 | HOME_DEVICES_QOD.QOS_TOO_HIGH | "DSCP requested is above the maximum QoS permitted." |
|10 |409 | HOME_DEVICES_QOD.OCCUPANCY_ABOVE_THRESHOLD | "The occupancy is above the allowed threshold." |
|11 |409 | HOME_DEVICES_QOD.NOT_CONNECTED_TO_REQUIRED_INTERFACE | "Device is not connected to the required interface (e.g. WiFi 5GHz interface)." |
|12 |409 | HOME_DEVICES_QOD.NOT_SUPPORTED_REQUIRED_INTERFACE | "Device does not support required interface (e.g. WiFi 5GHz interface)." |
|13 |409 | HOME_DEVICES_QOD.QOS_ALREADY_SET_TO_DEFAULT | "Device DSCP value is already set to default value." |
|14  |500 | INTERNAL | "Server error" |
|15  |503 | UNAVAILABLE | "Service unavailable" |
|16  |504 | TIMEOUT | "Request timeout exceeded. Try later." |

## 3.4. Policies

N/A

## 3.5. Code snippets

The following snippet elaborates REST based API call with `curl` to set the desired DSCP value (e.g. "CS0") for a user home device (with private IP "192.168.1.27").

*Please note, the credentials for API authentication purposes need to be adjusted based on target security system configuration.*

```
curl -X 'PUT' `https://sample-base-url/home-devices-qod/v0/dscp`
-H 'accept: application/json'
-H 'Content-Type: application/json'
-H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbG...."
-d '{"dscp": "CS0", "ip_address": "192.168.1.27"}'
```

If DSCP is properly applied, the response will be:

```
204 New DSCP value passed all validations and was applied
```
...with no body content.

## 3.6. FAQs

> FAQs will be added in a later version of the documentation

## 3.7. Terms

N/A

## 3.8. Release Notes

N/A

## 3.9. Pricing

N/A

<br>

# 4. References

<a name="1">[1] [CAMARA Commonalities : Authentication and Authorization Concept for Service APIs](https://github.com/camaraproject/WorkingGroups/blob/main/Commonalities/documentation/CAMARA-AuthN-AuthZ-Concept.md)<br>
<a name="2">[2] [HTTP Status codes spec](https://restfulapi.net/http-status-codes)<br>
