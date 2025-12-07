terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-001001-us-east-1" # Назва S3-бакета
    key            = "lesson-7/terraform.tfstate"              # Шлях до файлу стейту
    region         = "us-east-1"                               # Регіон AWS
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
