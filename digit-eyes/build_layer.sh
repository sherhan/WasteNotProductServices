#!/bin/bash

cd functions/utils/
rm -rf lib
rm -f Gemfile.lock
bundle config set path './lib'
bundle install