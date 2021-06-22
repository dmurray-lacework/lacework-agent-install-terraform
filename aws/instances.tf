# ////////////////////////////////
# // Centos 7 Instance

resource "aws_instance" "centos" {
  connection {
    host        = aws_instance.centos[count.index].public_ip
    user        = var.aws_centos_ami_user
    private_key = file(var.aws_key_pair_file)
  }

  ami                         = data.aws_ami.centos.id
  instance_type               = var.instance_type
  key_name                    = var.aws_key_pair_name
  subnet_id                   = aws_subnet.lw_template_subnet.id
  vpc_security_group_ids      = ["${aws_security_group.lw_template_sg.id}"]
  associate_public_ip_address = true
  count                       = var.centos_count

  tags = {
    Name          = "${var.tag_name}_centos_template_${random_id.instance_id.hex}"
    X-Dept        = var.tag_dept
    X-Customer    = var.tag_customer
    X-Project     = var.tag_project
    X-Application = var.tag_application
    X-Contact     = var.tag_contact
    X-TTL         = var.tag_ttl
  }

  provisioner "file" {
    content     = data.template_file.config_json.rendered
    destination = "/tmp/config.json"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostname centos-lacework",
      "sudo mkdir -p /var/lib/lacework/config",
      "sudo mv /tmp/config.json /var/lib/lacework/config/config.json",
      "sudo yum -y install curl",
      "sudo curl -o ${var.install_dir}/install.sh ${var.install_sh_url}",
      "sudo chmod +x ${var.install_dir}/install.sh",
      "sudo ${var.install_dir}/install.sh"
    ]

  }
}

# ////////////////////////////////
# // Amazon 2 Instance

resource "aws_instance" "amazon2" {
  connection {
    host        = aws_instance.amazon2[count.index].public_ip
    user        = var.aws_amazon_image_user
    private_key = file(var.aws_key_pair_file)
  }

  ami                         = data.aws_ami.amazon2.id
  instance_type               = var.instance_type
  key_name                    = var.aws_key_pair_name
  subnet_id                   = aws_subnet.lw_template_subnet.id
  vpc_security_group_ids      = ["${aws_security_group.lw_template_sg.id}"]
  associate_public_ip_address = true
  count                       = var.amazon2_count

  tags = {
    Name          = "${var.tag_name}_amazon2_template_${random_id.instance_id.hex}"
    X-Dept        = var.tag_dept
    X-Customer    = var.tag_customer
    X-Project     = var.tag_project
    X-Application = var.tag_application
    X-Contact     = var.tag_contact
    X-TTL         = var.tag_ttl
  }
  provisioner "file" {
    content     = data.template_file.config_json.rendered
    destination = "/tmp/config.json"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostname amazon2-lacework",
      "sudo mkdir -p /var/lib/lacework/config",
      "sudo mv /tmp/config.json /var/lib/lacework/config/config.json",
      "sudo yum -y install curl",
      "sudo curl -o ${var.install_dir}/install.sh ${var.install_sh_url}",
      "sudo chmod +x ${var.install_dir}/install.sh",
      "sudo ${var.install_dir}/install.sh"
    ]

  }
  
}

# ////////////////////////////////
# // RHEL8 Instance

resource "aws_instance" "rhel8" {
  connection {
    host        = aws_instance.rhel8[count.index].public_ip
    user        = var.aws_amazon_image_user
    private_key = file(var.aws_key_pair_file)
  }

  ami                         = data.aws_ami.rhel8.id
  instance_type               = var.instance_type
  key_name                    = var.aws_key_pair_name
  subnet_id                   = aws_subnet.lw_template_subnet.id
  vpc_security_group_ids      = ["${aws_security_group.lw_template_sg.id}"]
  associate_public_ip_address = true
  count                       = var.rhel8_count

  tags = {
    Name          = "${var.tag_name}_rhel8_template_${random_id.instance_id.hex}"
    X-Dept        = var.tag_dept
    X-Customer    = var.tag_customer
    X-Project     = var.tag_project
    X-Application = var.tag_application
    X-Contact     = var.tag_contact
    X-TTL         = var.tag_ttl
  }

  provisioner "file" {
    content     = data.template_file.config_json.rendered
    destination = "/tmp/config.json"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostname rhel8-lacework",
      "sudo mkdir -p /var/lib/lacework/config",
      "sudo mv /tmp/config.json /var/lib/lacework/config/config.json",
      "sudo yum -y install curl",
      "sudo curl -o ${var.install_dir}/install.sh ${var.install_sh_url}",
      "sudo chmod +x ${var.install_dir}/install.sh",
      # "sudo ${var.install_dir}/install.sh"
    ]

  }
}

# ////////////////////////////////
# // Ubuntu 18.04 Instance

resource "aws_key_pair" "key" {
  key_name   = "my_key"
  public_key = file(pathexpand("~/.ssh/id_rsa.pub"))
}

resource "aws_instance" "ubuntu1804" {
  connection {
    host        = aws_instance.ubuntu1804[count.index].public_ip
    user        = var.aws_ubuntu_image_user
    private_key = file(var.aws_key_pair_file)
  }

  ami                         = data.aws_ami.ubuntu1804.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = aws_subnet.lw_template_subnet.id
  vpc_security_group_ids      = ["${aws_security_group.lw_template_sg.id}"]
  associate_public_ip_address = true
  count                       = var.ubuntu1804_count

  tags = {
    Name          = "${var.tag_name}_ubuntu1804_template_${random_id.instance_id.hex}"
    X-Dept        = var.tag_dept
    X-Customer    = var.tag_customer
    X-Project     = var.tag_project
    X-Application = var.tag_application
    X-Contact     = var.tag_contact
    X-TTL         = var.tag_ttl
  }

  provisioner "file" {
    content     = data.template_file.config_json.rendered
    destination = "/tmp/config.json"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostname ubuntu1804-lacework",
      "sudo mkdir -p /var/lib/lacework/config",
      "sudo mv /tmp/config.json /var/lib/lacework/config/config.json",
      "sudo apt-get install -y curl",
      "sudo curl -o ${var.install_dir}/install.sh ${var.install_sh_url}",
      "sudo chmod +x ${var.install_dir}/install.sh",
      "sudo ${var.install_dir}/install.sh"
    ]

  }
}

# ////////////////////////////////
# // SUSE 15 Instance

resource "aws_instance" "suse15" {
  connection {
    host        = aws_instance.suse15[count.index].public_ip
    user        = var.aws_amazon_image_user
    private_key = file(var.aws_key_pair_file)
  }

  ami                         = data.aws_ami.suse15.id
  instance_type               = var.instance_type
  key_name                    = var.aws_key_pair_name
  subnet_id                   = aws_subnet.lw_template_subnet.id
  vpc_security_group_ids      = ["${aws_security_group.lw_template_sg.id}"]
  associate_public_ip_address = true
  count                       = var.suse15_count

  tags = {
    Name          = "${var.tag_name}_suse15_template_${random_id.instance_id.hex}"
    X-Dept        = var.tag_dept
    X-Customer    = var.tag_customer
    X-Project     = var.tag_project
    X-Application = var.tag_application
    X-Contact     = var.tag_contact
    X-TTL         = var.tag_ttl
  }

  provisioner "file" {
    content     = data.template_file.config_json.rendered
    destination = "/tmp/config.json"
  }


  provisioner "remote-exec" {
    inline = [
      "echo SLEEP",
      "sleep 20",
      "sudo hostname suse15-lacework",
      "sudo mkdir -p /var/lib/lacework/config",
      "sudo mv /tmp/config.json /var/lib/lacework/config/config.json",
      "sleep 20",
      "sudo zypper addrepo -f https://packages.lacework.net/RPMS/x86_64/lacework-prod.repo",
      "sleep 20",
      "sudo zypper install -y lacework",
    ]

  }
}

# ////////////////////////////////
# // SUSE 15 SP1 Instance 

resource "aws_instance" "suse15sp1" {
  connection {
    host        = aws_instance.suse15sp1[count.index].public_ip
    user        = var.aws_amazon_image_user
    private_key = file(var.aws_key_pair_file)
  }

  ami                         = data.aws_ami.suse15sp1.id
  instance_type               = var.instance_type
  key_name                    = var.aws_key_pair_name
  subnet_id                   = aws_subnet.lw_template_subnet.id
  vpc_security_group_ids      = ["${aws_security_group.lw_template_sg.id}"]
  associate_public_ip_address = true
  count                       = var.suse15sp1_count

  tags = {
    Name          = "${var.tag_name}_suse15sp1_template_${random_id.instance_id.hex}"
    X-Dept        = var.tag_dept
    X-Customer    = var.tag_customer
    X-Project     = var.tag_project
    X-Application = var.tag_application
    X-Contact     = var.tag_contact
    X-TTL         = var.tag_ttl
  }

  provisioner "file" {
    content     = data.template_file.config_json.rendered
    destination = "/tmp/config.json"
  }


  provisioner "remote-exec" {
    inline = [
      "echo SLEEP",
      "sleep 20",
      "sudo hostname suse15sp1-lacework",
      "sudo mkdir -p /var/lib/lacework/config",
      "sudo mv /tmp/config.json /var/lib/lacework/config/config.json",
      "sleep 20",
      "sudo zypper addrepo -f https://packages.lacework.net/RPMS/x86_64/lacework-prod.repo",
      "sleep 20",
      "sudo zypper install -y lacework",
    ]

  }
}

# ////////////////////////////////
# // Debian 10 Instance

resource "aws_instance" "debian10" {
  connection {
    host        = aws_instance.debian10[count.index].public_ip
    user        = var.aws_debian_image_user
    private_key = file(var.aws_key_pair_file)
  }

  ami                         = data.aws_ami.debian10.id
  instance_type               = var.instance_type
  key_name                    = var.aws_key_pair_name
  subnet_id                   = aws_subnet.lw_template_subnet.id
  vpc_security_group_ids      = ["${aws_security_group.lw_template_sg.id}"]
  associate_public_ip_address = true
  count                       = var.debian10_count

  tags = {
    Name          = "${var.tag_name}_debian10_template_${random_id.instance_id.hex}"
    X-Dept        = var.tag_dept
    X-Customer    = var.tag_customer
    X-Project     = var.tag_project
    X-Application = var.tag_application
    X-Contact     = var.tag_contact
    X-TTL         = var.tag_ttl
  }

  provisioner "file" {
    content     = data.template_file.config_json.rendered
    destination = "/tmp/config.json"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostname debian10-lacework",
      "sudo mkdir -p /var/lib/lacework/config",
      "sudo mv /tmp/config.json /var/lib/lacework/config/config.json",
      "sudo apt-get install -y curl",
      "sudo curl -o ${var.install_dir}/install.sh ${var.install_sh_url}",
      "sudo chmod +x ${var.install_dir}/install.sh",
      "sudo ${var.install_dir}/install.sh"
    ]

  }
}
