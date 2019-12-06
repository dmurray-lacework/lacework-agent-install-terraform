# ////////////////////////////////
# // Centos 7 Instance

resource "aws_instance" "centos" {
  connection {
    host        = "${aws_instance.centos.public_ip}"
    user        = "${var.aws_centos_ami_user}"
    private_key = "${file("${var.aws_key_pair_file}")}"
  }

  ami                         = "${data.aws_ami.centos.id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.aws_key_pair_name}"
  subnet_id                   = "${aws_subnet.lw_template_subnet.id}"
  vpc_security_group_ids      = ["${aws_security_group.lw_template_sg.id}"]
  associate_public_ip_address = true

  tags = {
    Name          = "${var.tag_name}_centos_template_${random_id.instance_id.hex}"
    X-Dept        = "${var.tag_dept}"
    X-Customer    = "${var.tag_customer}"
    X-Project     = "${var.tag_project}"
    X-Application = "${var.tag_application}"
    X-Contact     = "${var.tag_contact}"
    X-TTL         = "${var.tag_ttl}"
  }

  provisioner "file" {
    content     = "${data.template_file.config_json.rendered}"
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
    host        = "${aws_instance.amazon2.public_ip}"
    user        = "${var.aws_amazon_image_user}"
    private_key = "${file("${var.aws_key_pair_file}")}"
  }

  ami                         = "${data.aws_ami.amazon2.id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.aws_key_pair_name}"
  subnet_id                   = "${aws_subnet.lw_template_subnet.id}"
  vpc_security_group_ids      = ["${aws_security_group.lw_template_sg.id}"]
  associate_public_ip_address = true

  tags = {
    Name          = "${var.tag_name}_amazon2_template_${random_id.instance_id.hex}"
    X-Dept        = "${var.tag_dept}"
    X-Customer    = "${var.tag_customer}"
    X-Project     = "${var.tag_project}"
    X-Application = "${var.tag_application}"
    X-Contact     = "${var.tag_contact}"
    X-TTL         = "${var.tag_ttl}"
  }
  provisioner "file" {
    content     = "${data.template_file.config_json.rendered}"
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
    host        = "${aws_instance.rhel8.public_ip}"
    user        = "${var.aws_amazon_image_user}"
    private_key = "${file("${var.aws_key_pair_file}")}"
  }

  ami                         = "${data.aws_ami.rhel8.id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.aws_key_pair_name}"
  subnet_id                   = "${aws_subnet.lw_template_subnet.id}"
  vpc_security_group_ids      = ["${aws_security_group.lw_template_sg.id}"]
  associate_public_ip_address = true

  tags = {
    Name          = "${var.tag_name}_rhel8_template_${random_id.instance_id.hex}"
    X-Dept        = "${var.tag_dept}"
    X-Customer    = "${var.tag_customer}"
    X-Project     = "${var.tag_project}"
    X-Application = "${var.tag_application}"
    X-Contact     = "${var.tag_contact}"
    X-TTL         = "${var.tag_ttl}"
  }

  provisioner "file" {
    content     = "${data.template_file.config_json.rendered}"
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
      "sudo ${var.install_dir}/install.sh"
    ]

  }
}

# ////////////////////////////////
# // Ubuntu 18.04 Instance

resource "aws_instance" "ubuntu1804" {
  connection {
    host        = "${aws_instance.ubuntu1804.public_ip}"
    user        = "${var.aws_ubuntu_image_user}"
    private_key = "${file("${var.aws_key_pair_file}")}"
  }

  ami                         = "${data.aws_ami.ubuntu1804.id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.aws_key_pair_name}"
  subnet_id                   = "${aws_subnet.lw_template_subnet.id}"
  vpc_security_group_ids      = ["${aws_security_group.lw_template_sg.id}"]
  associate_public_ip_address = true

  tags = {
    Name          = "${var.tag_name}_ubuntu1804_template_${random_id.instance_id.hex}"
    X-Dept        = "${var.tag_dept}"
    X-Customer    = "${var.tag_customer}"
    X-Project     = "${var.tag_project}"
    X-Application = "${var.tag_application}"
    X-Contact     = "${var.tag_contact}"
    X-TTL         = "${var.tag_ttl}"
  }

  provisioner "file" {
    content     = "${data.template_file.config_json.rendered}"
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
    host        = "${aws_instance.suse15.public_ip}"
    user        = "${var.aws_amazon_image_user}"
    private_key = "${file("${var.aws_key_pair_file}")}"
  }

  ami                         = "${data.aws_ami.suse15.id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.aws_key_pair_name}"
  subnet_id                   = "${aws_subnet.lw_template_subnet.id}"
  vpc_security_group_ids      = ["${aws_security_group.lw_template_sg.id}"]
  associate_public_ip_address = true

  tags = {
    Name          = "${var.tag_name}_suse15_template_${random_id.instance_id.hex}"
    X-Dept        = "${var.tag_dept}"
    X-Customer    = "${var.tag_customer}"
    X-Project     = "${var.tag_project}"
    X-Application = "${var.tag_application}"
    X-Contact     = "${var.tag_contact}"
    X-TTL         = "${var.tag_ttl}"
  }

  provisioner "file" {
    content     = "${data.template_file.config_json.rendered}"
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
      "sudo zypper install -y curl",
      "sleep 20",
      "sudo curl -o ${var.install_dir}/${var.rpm_name} ${var.rpm_url}",
      "sudo zypper install -y --allow-unsigned-rpm ${var.install_dir}/${var.rpm_name}"
    ]

  }
}

# ////////////////////////////////
# // Debian 10 Instance

resource "aws_instance" "debian10" {
  connection {
    host        = "${aws_instance.debian10.public_ip}"
    user        = "${var.aws_debian_image_user}"
    private_key = "${file("${var.aws_key_pair_file}")}"
  }

  ami                         = "${data.aws_ami.debian10.id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.aws_key_pair_name}"
  subnet_id                   = "${aws_subnet.lw_template_subnet.id}"
  vpc_security_group_ids      = ["${aws_security_group.lw_template_sg.id}"]
  associate_public_ip_address = true

  tags = {
    Name          = "${var.tag_name}_suse15_template_${random_id.instance_id.hex}"
    X-Dept        = "${var.tag_dept}"
    X-Customer    = "${var.tag_customer}"
    X-Project     = "${var.tag_project}"
    X-Application = "${var.tag_application}"
    X-Contact     = "${var.tag_contact}"
    X-TTL         = "${var.tag_ttl}"
  }

  provisioner "file" {
    content     = "${data.template_file.config_json.rendered}"
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
