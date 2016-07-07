# IAM Objects

# Users

resource "aws_iam_user" "wicksycv" {
  provider = "aws.ireland"
  name = "wicksycv"
}

resource "aws_iam_user_policy" "wicksycv" {
  provider = "aws.ireland"
  name = "AllowFullWicksyCVBucket"
  user = "${aws_iam_user.wicksycv.name}"
  policy = "${template_file.s3_wicksycv_bucket.rendered}"
}

