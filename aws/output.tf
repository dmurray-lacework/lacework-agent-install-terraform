////////////////////////////////
// Outputs
output "centos_public_ip" {
  value = "${aws_instance.centos.public_ip}"
}

output "amazon2_public_ip" {
  value = "${aws_instance.amazon2.public_ip}"
}

output "rhel8_public_ip" {
  value = "${aws_instance.rhel8.public_ip}"
}

output "ubuntu_public_ip" {
  value = "${aws_instance.ubuntu1804.public_ip}"
}

output "suse15_public_ip" {
  value = "${aws_instance.suse15.public_ip}"
}

output "debian10_public_ip" {
  value = "${aws_instance.debian10.public_ip}"
}