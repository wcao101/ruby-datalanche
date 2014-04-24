#!/bin/bash

find . -type f -name "*~" -exec rm -f {} \; # remove gedit temp files
rm -f datalanche*.gem
gem build datalanche.gemspec
gem push datalanche*.gem
