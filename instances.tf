resource "aws_instance" "prometheus" {
  ami                         = "ami-020b5b93d0b33db24"
  instance_type               = "t2.micro"
  associate_public_ip_address = "false"
  availability_zone           = module.vpc.azs[0]
  disable_api_termination     = false
  iam_instance_profile        = aws_iam_instance_profile.put_S3.name
  key_name                    = aws_key_pair.main.id

  vpc_security_group_ids = [aws_default_security_group.default.id, aws_security_group.public.id]
  subnet_id              = module.vpc.private_subnets[0]

  root_block_device {
    delete_on_termination = false
    encrypted             = false
    volume_size           = 30
    volume_type           = "gp3"

    tags = local.tags
  }


  user_data = <<-EOF
                    #!/bin/bash
                    sudo apt update
                    sudo apt install apt-transport-https ca-certificates curl software-properties-common
                    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
                    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
                    sudo apt update
                    sudo apt install docker-ce
                    sudo docker run -d prom/node-exporter:latest


                EOF
}
#  provisioner "remote-exec" {
#   inline = ["pwd"]

#  connection {
#    host        = self.pablic_ip
#    type        = "ssh"
#    user        = "ubuntu"
#    private_key = file(var.ssh_key_private)
#  }

# }

#provisioner "local-exec" {
#  command = "ansible-playbook -u ubuntu -i '${self.public_ip},' --private-key ${var.ssh_key_private} docker.yml"
#}






