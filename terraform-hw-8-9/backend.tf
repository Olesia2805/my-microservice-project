terraform {
  required_version = ">= 1.0"

  backend "s3" {
    bucket         = "terraform-state-bucket-001001-us-east-1"
    key            = "lesson-8-9/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
