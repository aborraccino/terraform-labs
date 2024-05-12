resource "aws_instance" "webserver" {
  ami = "ami-0776c814353b4814d"
  instance_type = "t2.micro"
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install ngnix -y",
      "sudo systemctl enable ngnix",
      "sudo systemctl start ngnix"
    ]
  }
  connection {
    type = "ssh"
    host = self.public_ip
    user = "ubuntu"
  }
  key_name = aws_key_pair.web.id
  vpc_security_group_ids = [ aws_security_group.ssh-access-provisioners.id ]
}

resource "aws_security_group" "ssh-access-provisioners" {
  name = "ssh-access-provisioners"
  description = "Allow SSH access from the internet"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "web" {
  public_key = file("/home/aborraccino/.ssh/id_rsa/aws-ec2.pub")
}

