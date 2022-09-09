
terraform{
    required_version = "~>1.0"
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~>4.0"
      }
    }

    backend "s3" {
      bucket = "my-terraform-bucket-sample"
      key = "terraform-tfstate-file/terraform.tfstate"
      region = "us-east-2"
      access_key = "AKIAUJ26YJROIXGJZ5AJ"
      secret_key = "p2clxV/UicX3mZPiF4U+GnYkwXSanLpe44V2tPYo"
      dynamodb_table = "terraform_table"
    }
}

provider "aws" {
  region = var.aws_region
  profile = "default"
}
