### CV to demonstrate DevOps Linux skills

#### About

The idea of this repo is to provide a web based version of my CV, deployable using automation to showcase some of my skills.

Tech stack includes:

- Vagrant
- Linux
- Saltstack
- Docker
- Mkdocs
- Markdown

#### Requirements

The following software is required:

- Virtualbox
- Vagrant

Deployment has been successfully tested with:

- Virtualbox 5.0.12 r104815
- Vagrant 1.8.1
- OSX 10.10.5

#### Deployment Instructions

```
$ git clone https://github.com/wicksy/CV
$ cd CV/vagrant
$ vagrant up wicksycv --provision --provider virtualbox
```

Once the provisioning has completed, the CV should be available from:

http://192.168.168.192:8080/

#### Teardown Instructions

```
$ vagrant destroy wicksycv --force
```

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

I've created an IAM user, policy and S3 bucket (with policies) in AWS using Terraform, which contains the static content built using `mkdocs build`.

The URL for this version is available [here](http://wicksy-cv.s3-website-eu-west-1.amazonaws.com/).

#### Future Plans

Plans for additional content include using:

- Terraform (DONE)
- AWS S3 and IAM (DONE)
- Python
- Bash
- Boto3
- Hugo
