////////////////////////////////
// VPC 

resource "aws_vpc" "lw_template_vpc" {
  cidr_block = "10.0.0.0/16"

  tags  = {
    Name          = "${var.tag_name}_vpc"
    X-Dept        = var.tag_dept
    X-Customer    = var.tag_customer
    X-Project     = var.tag_project
    X-Contact     = var.tag_contact
    X-Application = var.tag_application
    X-TTL         = var.tag_ttl
  }
}

resource "aws_internet_gateway" "lw_template_gateway" {
  vpc_id = aws_vpc.lw_template_vpc.id

  tags = {
    Name = "lw_template_gateway_${random_id.instance_id.hex}"
  }
}

resource "aws_route" "lw_internet_access" {
  route_table_id         = aws_vpc.lw_template_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.lw_template_gateway.id
}

resource "aws_subnet" "lw_template_subnet" {
  vpc_id                  = aws_vpc.lw_template_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "lw_template_subnet_${random_id.instance_id.hex}"
  }
}