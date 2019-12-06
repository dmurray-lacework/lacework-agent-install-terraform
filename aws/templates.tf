////////////////////////////////
// Templates

data "template_file" "config_json" {
  template = "${file("${path.module}/../templates/config.json")}"

  vars = {
    accesstoken = "${var.accesstoken}"
  }
}