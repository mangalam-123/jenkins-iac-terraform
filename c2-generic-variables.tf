
variable "aws_region" {
    type = string
    default = "us-east-2"
    description = "The deafult region."
}

variable "instance_type" {
    type = string
    default = "t2.micro"
    description = "The instance type of the resource"

}

variable "instance_key" {
  type = string
  default = "Terraform-key"
  description = "The default key of the region"
}

variable "vpc_cidr" {
    type = string
    default = "10.230.0.0/16"
    description = "The vpc cidr block range."
  
}

variable "pub_subnet_cidr" {
  type = list(string)
  default = [ "10.230.0.0/27", "10.230.0.32/27" ]
  description = "The public subnet cidr"
}

variable "prvt_subnet_cidr" {
    type = list(string)
    default = [ "10.230.0.64/27", "10.230.0.96/27" ]
    description = "The private subnet cidr"
}

variable "database_subnet_cidr" {
    type = list(string)
    default = [ "10.230.0.128/27", "10.230.0.160/27" ]
    description = "The database subnet cidr"
  
}

variable "Az" {
    type = list(string)
    default = [ "us-east-2a", "us-east-2b" ]
    description = "The availability zones"
  
}

