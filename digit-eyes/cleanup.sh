#!/bin/bash

# remove all build dirs
rm -rf ./packages
rm -rf ./.aws-sam
rm -rf ./.bundle

# remove utils directory
rm -rf ./functions/utils/.bundle
rm -rf ./functions/utils/vendor

# remove Gemfiles
rm ./functions/request_product_details/Gemfile.lock
rm ./functions/utils/Gemfile.lock