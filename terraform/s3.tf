# S3 Objects

# Buckets

resource "aws_s3_bucket" "s3_wicksycv_bucket" {
  provider = "aws.ireland"
  bucket = "${var.s3_wicksycv_bucket}"
  policy = "${template_file.s3_wicksycv_static.rendered}"
  acl = "public-read"

  website {
    index_document = "index.html"
  }

  tags {
    Name = "${var.s3_wicksycv_bucket}"
    Stack = "${var.stack}"
    Project = "wicksycv"
  }

}
