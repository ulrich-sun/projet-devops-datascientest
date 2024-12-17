resource "tls_private_key" "rsa-4096-example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ds_key" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa-4096-example.public_key_openssh
}

resource "local_file" "ds_key" {
  filename        = var.filename
  content         = tls_private_key.rsa-4096-example.private_key_pem
  file_permission = "0400"
}
