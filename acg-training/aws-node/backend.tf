terraform {
  backend "s3" {
    region = "us-west-2"
    key = "terraformstatefile"
    bucket = "kourosh-bucket"
  }
}
