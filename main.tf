provider "aws"{
  region     = "ap-south-1"
}
resource "aws_s3_bucket" "firstbucket" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}