# Global Settings

provider "aws" {
  alias = "ireland"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_ireland_region}"
}

provider "aws" {
  alias = "frankfurt"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_frankfurt_region}"
}
