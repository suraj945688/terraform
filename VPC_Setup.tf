provider "aws"{
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}
resource "aws_s3_bucket" "firstbucket" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}