**User Story: Configure traffic profile (DSCP)**
<br>

| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As an application developer belonging to an enterprise, I want to request (using my application server/backend service) specific traffic profiles (DSCP marks) to be configured at my end-user’s residential home WiFi Access Point in order to ensure the Quality of Experience I need for my service/app.  |
| ***Roles, Actors and Scope*** | **Roles:** Customer:User<br> **Actors:** Application service providers, hyperscalers, application developers. <br> **Scope:** Configure traffic profiles to ensure needed Quality of Experience for a given device within a Residential LAN |
| ***Pre-conditions*** |The preconditions are listed below:<br><ol><li>The End-user is connected to a Residential WiFi Access Point.</li><li>The End-user is running an application/service developed by the Customer (Application Developer) that includes calls to the API.</li><li>Security and Privacy requirements are fulfilled as defined in Commonalities.</li></ol>|
| ***Activities/Steps*** | **Starts when:** The server/backend service calls the API specifying the traffic profile (DSCP) required and the target device.<br>**Ends when:** The requested traffic profile (DSCP) has been configured and the server/backend has being informed about it.<br> |
| ***Post-conditions*** | Traffic profile (DSCP) is applied and Customer (Application Developer) app/service continues. |
| ***Exceptions*** | Several exceptions might occur during the Home Devices QoS API operations<br><ul><li>Unauthorized: Not valid credentials (e.g. use of already expired access token).</li><li>Invalid input: Not valid input data to invoke operation (e.g. invalid IP Address, invalid DSCP, etc).</li><li>Denied by Carrier: Traffic profile cannot be implemented (already too many traffic profiles configures, Device is not connected to the required interface, etc), Server error, Service unavailable, request time exceeded, etc.</li></ul> |
