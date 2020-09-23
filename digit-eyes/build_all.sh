#!/bin/bash

echo '>>> Building dependencies layer....'
./build_layer.sh
echo '>>> dependencies layer build complete.'
echo '>>> Building lambda deployment package....'
sam build --use-container
echo '>>> lambda deployment package build complete.'
