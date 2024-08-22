# Changelog HomeDevicesQoD

## Table of Contents

- **[r1.2](#r12)**
- **[r1.1](#r11)**
- [v0.3.0](#v030)
- [v0.2.0](#v020)
- [v0.1.0 - Initial contribution](#v010---initial-contribution)

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

The below sections record the changes for each API version in each release as follows:

* for each first alpha or release-candidate API version, all changes since the release of the previous public API version
* for subsequent alpha or release-candidate API versions, the delta with respect to the previous pre-release
* for a public API version, the consolidated changes since the release of the previous public API version

# r1.2

## Release Notes

This release contains the definition and documentation of
* home-devices-qod v0.4.0

The API definition(s) are based on
* Commonalities v0.4.0
* Identity and Consent Management v0.2.0

## home-devices-qod v0.4.0

**home-devices-qod v0.4.0 is the public release for v0.4.0 of the HomeDevicesQoD API.**

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/HomeDevicesQoD/r1.2/code/API_definitions/home-devices-qod.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/HomeDevicesQoD/r1.2/code/API_definitions/home-devices-qod.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/HomeDevicesQoD/blob/r1.2/code/API_definitions/home-devices-qod.yaml)

**Main Changes**

* API and test definitions updated to conform to the Commonalities v0.4.0 and Identity and Consent Management v0.2.0 guidelines included in the CAMARA Fall24 meta-release. No new features were added.

### Added

* N/A

### Changed

* API spec update for Fall24 meta-release by @jpengar in https://github.com/camaraproject/HomeDevicesQoD/pull/64
* Update testing definitions in .feature file for Fall24 meta-release by @jpengar in https://github.com/camaraproject/HomeDevicesQoD/pull/65
* Update filenames to kebab-case format by @jpengar in https://github.com/camaraproject/HomeDevicesQoD/pull/70

### Fixed

* N/A

### Removed

* N/A

## New Contributors
* @hdamker made their first contribution in https://github.com/camaraproject/HomeDevicesQoD/pull/62

**Full Changelog**: https://github.com/camaraproject/HomeDevicesQoD/compare/v0.3.0...r1.2

# r1.1

## Release Notes

This release contains the definition and documentation of
* home-devices-qod v0.4.0-rc.1

The API definition(s) are based on
* Commonalities v0.4.0
* Identity and Consent Management v0.2.0

## home-devices-qod v0.4.0-rc.1

**home-devices-qod v0.4.0-rc.1 is the first release-candidate version for v0.4.0 of the HomeDevicesQoD API.**

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/HomeDevicesQoD/r1.1/code/API_definitions/home_devices_qod.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/HomeDevicesQoD/r1.1/code/API_definitions/home_devices_qod.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/HomeDevicesQoD/blob/r1.1/code/API_definitions/home_devices_qod.yaml)

**Main Changes**

* API and test definitions updated to conform to the Commonalities v0.4.0 and Identity and Consent Management v0.2.0 guidelines included in the CAMARA Fall24 meta-release. No new features were added.

### Added

* N/A

### Changed

* Update and review codeowners and maintainers md file by @hdamker in https://github.com/camaraproject/HomeDevicesQoD/pull/62
* Update README.md according to camaraproject/Template_Lead_Repository by @jpengar in https://github.com/camaraproject/HomeDevicesQoD/pull/67
* API spec update for Fall24 meta-release by @jpengar in https://github.com/camaraproject/HomeDevicesQoD/pull/64
* Update testing definitions in .feature file for Fall24 meta-release by @jpengar in https://github.com/camaraproject/HomeDevicesQoD/pull/65
* Update with the new API-Readiness-Checklist.md for Fall24 meta-release by @jpengar in https://github.com/camaraproject/HomeDevicesQoD/pull/66

### Fixed

* N/A

### Removed

* N/A

## New Contributors
* @hdamker made their first contribution in https://github.com/camaraproject/HomeDevicesQoD/pull/62

**Full Changelog**: https://github.com/camaraproject/HomeDevicesQoD/compare/v0.3.0...r1.1

# v0.3.0

**This is the second alpha release of Home Devices QoD API**.

- API definition **with inline documentation**:
  - OpenAPI [YAML spec file](https://github.com/camaraproject/HomeDevicesQoD/blob/release-0.3.0/code/API_definitions/home_devices_qod.yaml)
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/HomeDevicesQoD/release-0.3.0/code/API_definitions/home_devices_qod.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/HomeDevicesQoD/release-0.3.0/code/API_definitions/home_devices_qod.yaml)
- API additional [related documentation](https://github.com/camaraproject/HomeDevicesQoD/tree/release-0.3.0/documentation/API_documentation)

## Please note 

- This release includes changes to be compliant with the [Design Guidelines](https://github.com/camaraproject/Commonalities/blob/release-0.3.0/documentation/API-design-guidelines.md) and other documents in [release v0.3 of CAMARA Commonalities](https://github.com/camaraproject/Commonalities/tree/release-0.3.0).
- This is another v0.x release and further releases before the first stable major v1.x release might introduce breaking changes (e.g. API changes to align with Commonalities updates)

### Added

* Adopt linting rules tooling as described in [Implementation Guideline](https://github.com/camaraproject/Commonalities/blob/release-0.3.0/documentation/API-linting-Implementation-Guideline.md) by @jpengar in https://github.com/camaraproject/HomeDevicesQoD/pull/58
  
### Changed

* Align API spec format with the latest Commonalities agreements (last version - [release v0.3.0](https://github.com/camaraproject/Commonalities/releases/tag/v0.3.0)) by @jpengar in https://github.com/camaraproject/HomeDevicesQoD/pull/58

### Fixed

* N/A

### Removed

* N/A

## New Contributors
* N/A

**Full Changelog**: https://github.com/camaraproject/HomeDevicesQoD/compare/v0.2.0...v0.3.0

# v0.2.0

**This is the first alpha release of Home Devices QoD API**.

- API definition **with inline documentation**:
  - OpenAPI [YAML spec file](https://github.com/camaraproject/HomeDevicesQoD/blob/release-0.2.0/code/API_definitions/home_devices_qod.yaml)
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/HomeDevicesQoD/release-0.2.0/code/API_definitions/home_devices_qod.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/HomeDevicesQoD/release-0.2.0/code/API_definitions/home_devices_qod.yaml)
- API additional [related documentation](https://github.com/camaraproject/HomeDevicesQoD/tree/release-0.2.0/documentation/API_documentation)

## Please note 
- This is an alpha version, it should be considered as a draft.

### Added

* N/A
  
### Changed

* [RFC4594](https://datatracker.ietf.org/doc/html/rfc4594)-based proposal to provide a service class instead of DSCP value by @jpengar in https://github.com/camaraproject/HomeDevicesQoD/pull/25
* Update Home Devices QoD API documentation to 0.2.0 by @jpengar in https://github.com/camaraproject/HomeDevicesQoD/pull/19 & https://github.com/camaraproject/HomeDevicesQoD/pull/38
* Move API documentation into API definition by @jpengar in https://github.com/camaraproject/HomeDevicesQoD/pull/38

### Fixed

* Align API spec format with the latest Commonalities agreements by @jpengar in https://github.com/camaraproject/HomeDevicesQoD/pull/34

### Removed

* Removed deprecated API documentation file by @jpengar in https://github.com/camaraproject/HomeDevicesQoD/pull/45

## New Contributors
* N/A

**Full Changelog**: https://github.com/camaraproject/HomeDevicesQoD/compare/v0.1.0...v0.2.0

# v0.1.0 - Initial contribution

**Initial contribution of the API definition for *QoS-on-demand* (QoD) control applied to devices connected to the user home network**, including initial API documentation.

- API definition:
  - OpenAPI [YAML spec file](https://github.com/camaraproject/HomeDevicesQoD/blob/release-0.1.0/code/API_definitions/home_devices_qod.yaml)
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/HomeDevicesQoD/release-0.1.0/code/API_definitions/home_devices_qod.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/HomeDevicesQoD/release-0.1.0/code/API_definitions/home_devices_qod.yaml)
- API [documentation](https://github.com/camaraproject/HomeDevicesQoD/tree/release-0.1.0/documentation/API_documentation)

## Please note 
- This "release" is only tagged to document the history of the API as initial contribution
- This is an alpha version, it should be considered as a draft.

## What's Changed
* Home Devices QoD api spec 0.1.0 contribution by @jpengar in https://github.com/camaraproject/HomeDevicesQoD/pull/12
* Home Devices QoD api user stories doc 0.1.0 contribution by @jpengar in https://github.com/camaraproject/HomeDevicesQoD/pull/10 
* Home Devices Qod api documentation 0.1.0 contribution by @jpengar in https://github.com/camaraproject/HomeDevicesQoD/pull/15

### Added

* Initial contribution
  
### Changed

* N/A

### Fixed

* N/A

### Removed

* N/A

## New Contributors
* N/A

**Full Changelog**: https://github.com/camaraproject/HomeDevicesQoD/commits/v0.1.0