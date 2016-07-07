# Templates

resource "template_file" "s3_wicksycv_bucket" {
  template = "templates/s3_wicksycv_bucket.tpl"
  vars {
    bucket_name = "${var.s3_wicksycv_bucket}"
  }
}

resource "template_file" "s3_wicksycv_static" {
  template = "templates/s3_static_policy.tpl"
  vars {
    bucket_name = "${var.s3_wicksycv_bucket}"
  }
}

