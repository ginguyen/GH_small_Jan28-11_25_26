terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "public_read" {
  bucket = "my-tf-log-bucket"
  acl    = "public-read"
  tags = {
    yor_trace = "a545ef8b-91aa-4d18-8047-6f629eb1d185"
  }
}
resource "aws_s3_bucket" "public_read_write" {
  acl = "public-read-write"

  bucket = "foo_name"
  versioning {
    enabled = false
  }
  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }
  tags = {
    yor_trace = "ffed738b-e7e8-4c5d-bde2-45066100c9b3"
  }
}

resource "aws_security_group" "allow_tcp" {
  name        = "allow_tcp"
  description = "Allow TCP inbound traffic"
  vpc_id      = aws_vpc.foo_vpc.id
  ingress {
    description = "TCP from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  egress {
    from_port = 69
    to_port   = 69
    protocol  = "udp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  tags = {
    yor_trace = "6d06e328-b8f0-491e-847c-440401d0bcc4"
  }
}