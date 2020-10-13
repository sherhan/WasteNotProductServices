 #!/bin/bash

InputTemplate=./template.yml
BuiltTemplate=./.aws-sam/build/template.yaml
DefaultLambda="RequestProductDetailsFunction"

run_unit_tests() {
  # run unit tests
  echo 'Unit Tests - generate signatures'
  ruby tests/unit/tc_request_product_details.rb --name /test_generate_signature*/
  echo 'Unit Tests - create query params'
  ruby tests/unit/tc_request_product_details.rb --name /test_create_query_params*/
}

run_lambda_locally() {
    sam local invoke -e events/HTTPRequestEvent.json $1
}

run_default() {
  run_unit_tests
  run_lambda_locally
}

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -u|--unit-test)
    run_unit_tests
    exit 0
    shift # past argument
    shift # past value
    ;;
    -l|--local-invoke)
    run_lambda_locally
    exit 0
    shift # past argument
    shift # past value
    ;;
    -a|--api)
    sam local start-api
    exit 0
    shift # past argument
    shift # past value
    ;;
    --default)
    DEFAULT=YES
    run_default
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

run local simulation of lambdas
if [ -z "$1" ]
then
  echo "no lambda function name supplied. Running default lambda: ${DefaultLambda}"
  run_lambda_locally $DefaultLambda
else
  echo "Running lambda deployment test locally for function: $1"
  run_lambda_locally $1
fi
