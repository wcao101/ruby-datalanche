#!/bin/bash

find . -type f -name "*~" -exec rm -f {} \; # remove gedit temp files
gem build datalanche.gemspec
sudo gem install datalanche*.gem
gem push datalanche*.gem
