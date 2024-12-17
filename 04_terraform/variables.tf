# variable "ami" {
# }
variable "instance_type" {
}
# variable "sg_id" {
# }
# variable "key_name" {
# }
# variable "subnet_id" {
# }
variable "vm_name" {
}

variable "eip_name" {
}

# variable "filename" {

# }

variable "key_name" {

}

variable "sg_ports" {
  default = [22, 80, 443, 30069, 30081, 30082, 8081, 8082, 8069]
}

variable "sg_name" {
}
# variable "vpc_id" {
# }

variable "rt_name" {
}
variable "igw_name" {
}
variable "vpc_name" {
}
variable "subnet_name" {

}
