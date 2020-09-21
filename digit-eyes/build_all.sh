#!/bin/bash

echo '>>> Building lib layer....'
./build_layer.sh
echo '>>> lib layer build complete.'
echo '>>> Building lambda deployment package....'
sam build #--use-container
echo '>>> lambda deployment package build complete.'
