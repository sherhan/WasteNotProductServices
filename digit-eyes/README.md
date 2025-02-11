# digit_eyes service
This project contains source code and supporting files for a serverless application that you can deploy with the SAM CLI. It provides lookup service for the digit-eyes api and includes the following files and folders:

- functions - Code for the application's Lambda functions to retrieve product details from the digit-eyes api.
- tests - Unit tests for the Lambda functions' application code.
- template.yaml - A template that defines the application's AWS resources.
- bash scripts - used to automate build, install, test and cleanup activities.

The application uses several AWS resources, including Lambda functions and an [PENDING]API Gateway API. These resources are defined in the `template.yaml` file in this project. You can update the template to add AWS resources through the same deployment process that updates the application code.

## Requirements

This application uses The Serverless Application Model Command Line Interface (SAM CLI) to automate the build, perform tests and deploy the application to AWS.

SAM CLI is an extension of the AWS CLI that adds functionality for building and testing Lambda applications. It uses Docker to run the servless functions in an Amazon Linux environment that matches Lambda. 

To use the SAM CLI, you need the following tools.

* SAM CLI - [Install the SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html)
* Ruby - [Install Ruby 2.7](https://www.ruby-lang.org/en/documentation/installation/)
* Docker - [Install Docker community edition](https://hub.docker.com/search/?type=edition&offering=community)

## Build

Build the application by running 

```bash
digit-eyes$ ./build.sh
```
This will create a folder './aws-sam' and create a local installation there ready for test or deployment. 

## Testing

A test suite can be executed by running:

```bash
digit-eyes$ ./run_tests.sh
```

'run_tests.sh' performs unit tests and runs lambda functions locally.

## Unit tests

Utit tests are defined in the `tests/unit/` folder in this project. And can be called by running the command

```bash
digit_eyes_client$ ruby tests/unit/tc_utils.rb 
```
## Cleanup

Running the cleanup script removes the SAM CLI build directory .aws-sam:

```bash
digit_eyes_client$ ./cleanup.sh
```