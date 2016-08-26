#!/bin/bash

# Build fresh site contents and upload to S3
#
SCRIPTNAME=$(basename $0)
DIRNAME=$(dirname $0)

# Setup for pip virtual environment
#
export WORKON_HOME=~/.pyenvironments
mkdir -p ${WORKON_HOME}

# Install pips for python virtual environment
#
pip install virtualenv virtualenvwrapper

# Source env wrapper
#
source /usr/local/bin/virtualenvwrapper.sh

# Make a virtual environment to install new pips
#
mkvirtualenv CV

# Install mkdocs pip
#
pip install mkdocs boto3

# Build a fresh copy of the site (cleanup before)
#
(cd ${DIRNAME}/../mkdocs/CV && mkdocs build --clean)

# Upload to S3
#
${DIRNAME}/CVtoS3.py

# Exit from the virtual environment and clean it up
#
deactivate
rmvirtualenv CV

exit 0
