terraform {
  required_version = ">=1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "<=5.0"
    }
  }
}

provider "aws" {
  region = var.region_name
  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.env_name
      Managed_by  = "Terraform"
    }
  }
}

resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_s3_bucket" "main" {
  bucket = "${var.bucket_name}-${random_string.bucket_suffix.result}"
  tags = {
    Name        = "Protected"
    CreatedDate = timestamp()
  }
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id
  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket                  = aws_s3_bucket.main.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "main" {
  bucket = aws_s3_bucket.main.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id
  policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Sid       = "PublicGetObject"
          Effect    = "Allow"
          Principal = "*"
          Action    = "s3:GetObject"
          Resource  = "${aws_s3_bucket.main.arn}/*"
        }
      ]
    }
  )
}

resource "aws_s3_object" "index" {
    bucket = aws_s3_bucket.main.id
    key = "index.html"
    source = "website_files/index.html"
    content_type = "text/html"
    etag         = filemd5("website_files/index.html")
}

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.main.id
  key          = "error.html"
  source       = "website_files/error.html"  # Path to your local file
  content_type = "text/html"
  etag         = filemd5("website_files/error.html")
}