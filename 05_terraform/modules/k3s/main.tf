resource "aws_instance" "ds_vm" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.sg_id]
  # security_groups = [var.sg_id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 10
    volume_type = "gp2"
  }
  root_block_device {
    delete_on_termination = true
  }

  tags = {
    Name = var.vm_name
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }
  provisioner "file" {
    source      = "./scripts/k3s.sh"
    destination = "/tmp/k3s.sh"

  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/k3s.sh",
      "/tmp/k3s.sh"
    ]
  }
  provisioner "local-exec" {
    command = "echo -e '\nansible_host: ${self.public_ip}' >> ../02_ansible/host_vars/k3s.yaml"

  }
}