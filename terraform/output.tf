# Output

output "s3_wicksycv_bucket.id" {
  value = "${aws_s3_bucket.s3_wicksycv_bucket.id}"
}

output "s3_wicksycv_bucket.region" {
  value = "${aws_s3_bucket.s3_wicksycv_bucket.region}"
}

output "wicksycv.unique_id" {
  value = "${aws_iam_user.wicksycv.unique_id}"
}

output "wicksycv.arn" {
  value = "${aws_iam_user.wicksycv.arn}"
}

