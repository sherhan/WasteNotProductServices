 #!/bin/bash

$InputTemplate = "./template.yml"
$BuiltTemplate = "./.aws-sam/build/template.yaml"

if [ -z "$1" ]
then
  echo "error: no lambda function name supplied."
else
  echo "Running lambda deployment test locally for function: $1"
  sam local invoke --no-event $1
fi
