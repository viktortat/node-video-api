# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

[0.1.0] 2019-05-21

### Changed

- Finalized V1 of the README
- Minor makefile tweaks/naming changes
- Lambda runtime upgraded to 10.x

[0.0.6] 2019-05-13

### Added

- Implemented the GetSignedUrl lambda
- Unit tests for the above lambda
- Helper functions and configs

### Removed

- Husky, need to come up with a different git hook strategy

[0.0.5] 2019-05-13

### Added

- Implemented the GetS3Contents lambda
- Accompanying unit tests
- Helper functions/configs
- New env variables injected via Terraform

[0.0.4] 2019-05-09

### Added

- Building and deploying only the production dependencies for the lambda functions to reduce bundle size

### Changed

- Changed zip path for the lambda functions to the root directory from the temp directory
- Updated path for lambda function source code and hash

### Removed

- The temp directory

[0.0.3] 2019-05-09

### Added

- Add API Gateway and attach to lambda functions
- Update lambda IAM permissions to be invoked by API Gateway

### Changed

- Update Terraform directory and move all files under a code directory

### Fixed

- Update makefile to zip lambda functions and deploy without directory structure
- Refactor

[0.0.2] 2019-05-08

### Added

- S3 bucket with encryption enabled
- Auto-approval for makefile deploy/destroy commands

### Fixed

- Permissions for lambdas to log to Cloudwatch

[0.0.1] 2019-05-07

### Added

- Basic skeleton for lambda functions
- Initial Terraform setup
- Linting configuration
- Project skeleton

### Documented

- Initial README and CHANGELOG
