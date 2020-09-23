#!/bin/bash

echo '>>> Building lambda deployment package....'
sam build --use-container
echo '>>> lambda deployment package build complete.'
