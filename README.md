# Lacework Agent Install   
This repo provides terraform code for deploying the Lacework workload agent for public cloud providers. 

## Requirements
- [Terraform 12.x](https://www.terraform.io/)

## Usage of Tags
The purpose of the tags in this repo are largely for controlling public cloud costs with teams. You will see that one of the tags is `tag_ttl` which has a default value of `4`. In previous companies we have configured a lambda function that will scan our AWS environments and destroy any resources that do not have `tag_ttl` set or are outside of the `tag_ttl` limit. With the default setting we setting that the environment will be up for 4 hours, and anything beyond that will be killed. If you need your environment up longer you can always set the tag to some larger setting like `730` i.e. 1 month. The other tags are designed for tracking costs across teams.

## AWS Usage
1. `cd aws/`
2. `terraform init`
3. `cp tfvars.example terraform.tfvars`
4. Edit `terraform.tfvars` with relevant values for your environment 