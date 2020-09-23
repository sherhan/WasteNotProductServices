 #!/bin/bash

InputTemplate=./template.yml
BuiltTemplate=./.aws-sam/build/template.yaml
DefaultLambda="RequestProductDetailsFunction"

# run unit tests
echo 'Unit Tests - generate signatures'
ruby tests/unit/tc_request_product_details.rb --name /test_generate_signature*/
echo 'Unit Tests - create query params'
ruby tests/unit/tc_request_product_details.rb --name /test_create_query_params*/

# run local simulation of lambdas
if [ -z "$1" ]
then
  echo "no lambda function name supplied. Running default lambda: ${DefaultLambda}"
  sam local invoke -e events/SchmackosEvent.json $DefaultLambda
else
  echo "Running lambda deployment test locally for function: $1"
  sam local invoke -e events/SchmackosEvent.json $1
fi
