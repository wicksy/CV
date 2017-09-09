#!/bin/bash

# Build image and run container specifically for Ubuntu Trusty where the docker salt states do
# not seem to work properly (work ok on Xenial). Complain that docker module has not been loaded
# even with multiple explicit reload_modules: true run beforehand.
#
cd /tmp/docker-lab/wicksycv && docker build -t wicksy/wicksycv:latest .
docker run --detach --name wicksycv --publish 8080:8080 --volume /tmp/CV/:/data/cv/ wicksy/wicksycv:latest bash -c "cd /data/cv/mkdocs && /usr/bin/mkdocs serve --dev-addr 0.0.0.0:8080 --theme material"
exit
