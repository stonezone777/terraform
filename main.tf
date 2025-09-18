_**Beginner Project: Static Website on AWS S3**_

_**main.tf**_

```terraform
# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

# Create an S3 bucket for the static website
resource "aws_s3_bucket" "website" {
  bucket = "my-terraform-static-website-example"

  tags = {
    Name        = "My Static Website"
    Environment = "Dev"
  }
}

# Configure the S3 bucket for website hosting
resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Upload the index.html file to the S3 bucket
resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.website.id
  key    = "index.html"
  source = "index.html"
  acl    = "public-read"
  content_type = "text/html"
}

# Upload the error.html file to the S3 bucket
resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.website.id
  key    = "error.html"
  source = "error.html"
  acl    = "public-read"
  content_type = "text/html"
}
```
