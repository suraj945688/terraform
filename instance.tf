provider "aws"{
  region     = "ap-south-1"
  access_key = "AKIAT6IWH4I74ZKAFXVI"
  secret_key = "4QYLtbtt9tQz1zIQoy0o9ClY8Y/P9gDL39EapnDZ"
}
resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}