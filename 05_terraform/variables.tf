
variable "instance_type" {
}

variable "stack" {
}

variable "sg_ports" {
  default = [22, 80, 443, 30069, 30081, 30082, 8081, 8082, 8069]
}
variable "sg_name" {
}
