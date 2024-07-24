# API Readiness Checklist

Checklist for home-devices-qod 0.4.0-rc.1 in r1.1

| Nr | API release assets  | alpha | release-candidate |  initial<br>public | stable<br> public | Status | Comments |
|----|----------------------------------------------|:-----:|:-----------------:|:-------:|:------:|:----:|----|
|  1 | API definition                               |   M   |         M         |    M    |    M   |   Y  | [home_devices_qod.yaml](/code/API_definitions/home_devices_qod.yaml) |
|  2 | Design guidelines from Commonalities applied |   O   |         M         |    M    |    M   |   Y  |      |
|  3 | Guidelines from ICM applied                  |   O   |         M         |    M    |    M   |   Y  |      |
|  4 | API versioning convention applied            |   M   |         M         |    M    |    M   |   Y  |      |
|  5 | API documentation                            |   M   |         M         |    M    |    M   |   Y  | Embedded in [API definition](/code/API_definitions/home_devices_qod.yaml) |
|  6 | User stories                                 |   O   |         O         |    O    |    M   |   Y  | [home_devices_qod_user_stories.md](/documentation/API_documentation/home_devices_qod_user_stories.md) |
|  7 | Basic API test cases & documentation         |   O   |         M         |    M    |    M   |   Y  | [home-devices-qod.feature](/code/Test_definitions/home-devices-qod.feature) |
|  8 | Enhanced API test cases & documentation      |   O   |         O         |    O    |    M   |   Y  | [home-devices-qod.feature](/code/Test_definitions/home-devices-qod.feature) |
|  9 | Test result statement                        |   O   |         O         |    O    |    M   |   N  |      |
| 10 | API release numbering convention applied     |   M   |         M         |    M    |    M   |   Y  |      |
| 11 | Change log updated                           |   M   |         M         |    M    |    M   |   Y  | [CHANGELOG.md](/CHANGELOG.md) |
| 12 | Previous public release was certified        |   O   |         O         |    O    |    M   |      |      |

To fill the checklist:
- in the line above the table, replace the api-name, api-version and the rx.y by their actual values for the current API version and release.
- in the Status column, put "Y" (yes) if the release asset is available or fulfilled in the current release, a "N" (no) or a "tbd". Example use of "tbd" is in case an alpha or release-candidate API version does not yet provide all mandatory assets for the release.
- in the Comments column, provide the link to the asset once available, and any other relevant comments.

Note: the checklists of a public API version and of its preceding release-candidate API version can be the same.

The documentation for the content of the checklist is here: [API Readiness Checklist](https://wiki.camaraproject.org/x/HQBFAQ)