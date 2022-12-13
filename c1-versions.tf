
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
      region = "us-east-1"
      dynamodb_table = "terraform_table"
    }
}

provider "aws" {
  region = var.aws_region
  
}
