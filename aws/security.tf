resource "aws_security_group" "lw_template_sg" {
  name        = "lw_template_sg_${random_id.instance_id.hex}"
  description = "Security group provisioned by Terraform template project"
  vpc_id      = aws_vpc.lw_template_vpc.id

  tags = {
    Name          = "lw_template_security_group_${var.tag_name}_${random_id.instance_id.hex}"
    X-Dept        = var.tag_dept
    X-Customer    = var.tag_customer
    X-Project     = var.tag_project
    X-Application = var.tag_application
    X-Contact     = var.tag_contact
    X-TTL         = var.tag_ttl
  }
}

//////////////////////////
// SG Rules 
resource "aws_security_group_rule" "ingress_allow_22_tcp_all" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lw_template_sg.id
}

# Egress: ALL
resource "aws_security_group_rule" "linux_egress_allow_0-65535_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lw_template_sg.id
}