
////////////////////////////////
// AWS Connection

variable "aws_profile" {}

variable "aws_region" {}

////////////////////////////////
// Server Settings

variable "aws_centos_ami_user" {
  default = "centos"
}

variable "aws_amazon_image_user" {
  default = "ec2-user"
}

variable "aws_ubuntu_image_user" {
  default = "ubuntu" 
}

variable "aws_debian_image_user" {
  default = "admin"
}


variable "instance_type" {
  default = "t2.micro"
}

variable "instance_count" {
  default = "1"
}

////////////////////////////////
// Tags

variable "tag_customer" {}

variable "tag_project" {}

variable "tag_name" {}

variable "tag_dept" {}

variable "tag_contact" {}

variable "tag_application" {}

variable "tag_ttl" {
  default = 4
}

variable "aws_key_pair_file" {}

variable "aws_key_pair_name" {}