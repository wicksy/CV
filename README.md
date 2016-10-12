[![Build Status](https://travis-ci.org/wicksy/CV.svg?branch=master)](https://travis-ci.org/wicksy/CV) [![license](https://img.shields.io/badge/License-MIT-blue.svg?maxAge=2592000)](https://github.com/wicksy/CV/blob/master/LICENSE.md)</br>

### CV to demonstrate DevOps Fu

![DevOpsFu logo](logos/devopsfu.png "Fu")</br>

#### About

The idea of this repo is to provide a web based version of my CV, deployable using automation, to showcase some of the technical
skills that I have in the areas of Linux, DevOps, Automation, Cloud, etc.

Tech stack includes:

- Vagrant
- Linux
- Saltstack
- Docker
- Mkdocs
- Markdown
- Terraform
- AWS S3 and IAM
- Python
- Boto3
- Bash
- Unit Tests (testinfra)

#### Requirements

The following software is required:

- Virtualbox
- Vagrant
- Python/Pip (to run tests)

Deployment has been successfully tested with:

- Virtualbox 5.0.12 r104815
- Vagrant 1.8.1
- Python 2.7.10
- Pip 8.1.1
- OSX 10.10.5

#### Deployment Instructions

```
$ git clone https://github.com/wicksy/CV
$ cd CV/vagrant
$ vagrant up wicksycv --provision --provider virtualbox
```

Once the provisioning has completed, the CV should be available from:

http://192.168.168.192:8080/

#### Tests

There are a number of tests implemented using the serverspec-like testing framework for Python [**testinfra**](https://github.com/philpep/testinfra). Tests
can be run using the `runtests.sh` bash script in the `test` directory:

```
$ cd CV/test
$ ./runtests.sh
```

The script will bring up the vagrant machine if not already, setup a python virtual environment, install testinfra and paramiko pips, run a series of test
packs through testinfra then clean up afterwards.

Sample output from one of the test packs (for packages):

```
========================================================= test session starts ==================================================================
platform darwin -- Python 2.7.10, pytest-3.0.1, py-1.4.31, pluggy-0.3.1 -- /Users/wicksy/.pyenvironments/CVtests/bin/python
cachedir: ../.cache
rootdir: /Users/wicksy/git/wicksy/CV, inifile:
plugins: testinfra-1.4.2
collected 8 items

../test/test_packages.py::test_packages[paramiko:/wicksycv-git] PASSED
../test/test_packages.py::test_packages[paramiko:/wicksycv-python2.7] PASSED
../test/test_packages.py::test_packages[paramiko:/wicksycv-python-pip] PASSED
../test/test_packages.py::test_packages[paramiko:/wicksycv-apt-transport-https] PASSED
../test/test_packages.py::test_packages[paramiko:/wicksycv-ca-certificates] PASSED
../test/test_packages.py::test_packages[paramiko:/wicksycv-docker-engine] PASSED
../test/test_packages.py::test_packages[paramiko:/wicksycv-salt-minion] PASSED
../test/test_packages.py::test_packages[paramiko:/wicksycv-salt-common] PASSED

======================================================== pytest-warning summary ================================================================
WP1 None Modules are already imported so can not be re-written: testinfra
============================================= 8 passed, 1 pytest-warnings in 0.66 seconds ======================================================
```

More information on **testinfra** can be found at https://github.com/philpep/testinfra

#### Teardown Instructions

```
$ vagrant destroy wicksycv --force
```

#### Builds

Builds are triggered automatically and run on [Travis CI](https://travis-ci.org/wicksy/CV/builds). The build will apply the Salt states in a build VM and run the tests to ensure code validity.

#### Known issues

To ensure the deployment is successful, it is recommended that the versions listed above are the minimum used as there are known issues with earlier versions. For example Vagrant 1.7.3 and 1.7.4 fail to deploy with:

```
Copying salt minion config to /etc/salt
Failed to upload a file to the guest VM via SCP due to a permissions
error. This is normally because the SSH user doesn't have permission
to write to the destination location. Alternately, the user running
Vagrant on the host machine may not have permission to read the file.
```

due to issue #5973 (https://github.com/mitchellh/vagrant/issues/5973)

#### AWS version

I've created an IAM user, policy and S3 bucket (with policies) in AWS using Terraform, which contains the static content built using `mkdocs build --clean`.

The URL for this version is available [here](http://wicksy-cv.s3-website-eu-west-1.amazonaws.com/).

The site content is rebuilt and uploaded to S3 using Python/Boto3 (`bin/CVtoS3.py`) wrapped by a Bash script (`bin/CVtoS3.sh`) that creates a Python
virtualenv, installs the mkdocs pip, removes and rebuilds the site content, clears down the S3 bucket and uploads the new site content to it.

```
$ cd bin
$ ./CVtoS3.sh
```

#### Future Plans

Plans for additional content include using:

- [Hugo](https://gohugo.io/)
