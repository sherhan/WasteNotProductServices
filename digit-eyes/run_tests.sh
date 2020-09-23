 #!/bin/bash

$InputTemplate = "./template.yml"
$BuiltTemplate = "./.aws-sam/build/template.yaml"
$DefaultLambda="RequestProductDetailsFunction"

# run unit tests
ruby tests/unit/tc_digiteyes_utils.rb
ruby tests/unit/tc_request_product_details.rb

# run local simulation of lambdas
if [ -z "$1" ]
then
  echo "no lambda function name supplied. Running default lambda: ${DefaultLambda}"
  sam local invoke --no-event $DefaultLambda
else
  echo "Running lambda deployment test locally for function: $1"
  sam local invoke --no-event $1
fi
