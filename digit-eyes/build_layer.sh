#!/bin/bash
BASE_DIR=$(PWD)
OUTPUT_DIR=$(PWD)/packages
OUTPUT_FILENAME=layer.zip
DEPENDENCIES_DIR=$(PWD)/functions/utils/

echo "Building dependencies from:" $DEPENDENCIES_DIR

# setup output dir
if [ ! -d "$OUTPUT_DIR" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  mkdir $OUTPUT_DIR
else 
   rm $OUTPUT_DIR/$OUTPUT_FILENAME
fi

# setup dependencies dir
cd $DEPENDENCIES_DIR
if [ ! -d "./vendor/bundle" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  mkdir ./vendor/bundle
else 
  rm -rf ./vendor
fi

# build dependencies in docker
docker run --rm \
           -v $DEPENDENCIES_DIR:/var/layer \
           -w /var/layer \
           lambci/lambda:build-ruby2.7 \
           bundle install --path=vendor/bundle

# clean up dir structure
mv vendor/bundle/ruby/* vendor/bundle/ && \
  rm -rf vendor/bundle/2.7.0/cache && \
  rm -rf vendor/bundle/ruby

# zip to output dir - 
cd $DEPENDENCIES_DIR
echo "Creating zip " $DEPENDENCIES_DIR$OUTPUT_FILENAME 
zip -r $OUTPUT_DIR/$OUTPUT_FILENAME ./vendor