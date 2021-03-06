# Node-Video-API

The purpose of this repository is to provide a serverless API for use with a frontend web UI. At the current moment it does two things, returns all the contents of an S3 bucket and generates a pre-signed URL for access to the objects for authorized users (which will be facilitated via AWS Cognito). This will likely be expanded upon as the React UI is built out and functionality is required. This API is implemented using AWS Lambda functions proxied by AWS API Gateway, and deployed via the command line using Terraform. In a later iteration, deployment will be facilitated by AWS CodePipeline.

## Getting Started

After cloning the repository to your local machine, the dependencies below must be installed locally in order to deploy the code to your AWS account. It is recommended that you install these dependencies in the order that they are listed.

### AWS

The first requirement is that your machine have a ".aws" folder containing AWS credentials and configs installed in your home directory. This is due to the fact that this code is meant to be deployed to AWS, and Terraform uses the credentials in its deployment process.

While the folder can be can be created manually, it is easier to install the AWS CLI tool following these directions: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html. Once you have installed the AWS CLI, run the command `aws configure` and follow the prompts by filling in information specific to your AWS account. This will require you to create an AWS IAM user in your account with programmatic access. For help, see this guide: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html.

Although this repository doesn't require the AWS CLI directly, it is still a fairly useful tool and a convenient way to interact with your AWS environment.

### Terraform

After AWS credentials have been configured on your local machine, follow this tutorial to install Terraform: https://learn.hashicorp.com/terraform/getting-started/install.html. Following this process will install a Terraform CLI that the commands in the makefile at the root of the repository rely upon.

### Node

The Node JavaScript runtime is used in this repository. The installers can be found here: https://nodejs.org/en/download/.

### NPM

The JavaScript package manager used by this repository is NPM. Follow the instructions here to install it: https://www.npmjs.com/get-npm.

### Initializing and Deploying

Once the above dependencies have been installed successfully, the commands listed in the makefile can be used to initialize and deploy the API. The makefile contains three commands, `init`, `deploy`, and `destroy`.

Prior to running the `make init` command, it is important to edit the \*.tfvars files and the backendConfig.tf file under the terraform/code/env directory. Replace the values defined in these files with values specific to your own account/preferences. Note, you must create the S3 bucket in AWS to host Terraform remote state (IE, `tf-backend-state-2019` in backendConfig.tf) prior to running any of the commands using Terraform.

After this configuration is done, run `make init` in the root of the project to initialize Terraform and configure the DEV, QA, and PROD Terraform workspaces (used as environments). For a summary of Terraform workspaces, see here: https://www.terraform.io/docs/state/workspaces.html.

Once the `init` command is successful, you are ready to run the `deploy` command from the root of the repository in order to deploy the API to AWS. The deploy command takes one parameter specifying the environment to which is is being deployed (leveraging Terraform workspaces). An example of running this command is `make deploy ENV=dev`, which would deploy using the Terraform "dev" workspace. Note, if you want to deploy different logical environments to different AWS accounts, this can be configured by potentially modifying the \*.tfvars files and leveraging AWS profiles (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html).

Finally, when you want to cleanup the resources that have been deployed from this repository, use the `destroy` command run from the root of the repository. Like the `deploy` command, it also takes a parameter specifying the environment to apply the action to. Similarly, an example of this command is `make destroy ENV=dev` which would destroy the resources in the Terraform "dev" workspace.

## Running the tests

Each of the Lambda functions has their own package.json file, with accompanying scripts in each. Additionally, each Lambda function has a /tests directory that contain the tests for each function respectively. The tests can be run using `npm test` in the root of each lambda function (IE, lambda/GetS3Contents/) after installing dependencies locally. In the planned CodePipeline integration, this command will be part of the build process in order to ensure reliable code is deployed.

## Planned Improvements

- CodePipeline integration
- Cognito integration for API Gateway
- All TODOS listed in the repo
- Whatever I find cool and interesting
