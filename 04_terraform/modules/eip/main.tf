resource "aws_eip" "ds_eip" {
  domain = "vpc"
  tags = {
    Name = var.eip_name
  }
}