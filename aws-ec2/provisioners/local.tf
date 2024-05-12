resource "aws_instance" "webserver" {
  ami = "ami-0776c814353b4814d"
  instance_type = "t2.micro"
  provisioner "local-exec" {
    command = "echo ${aws_instance.webserver.public_ip} >> /tmp/ips.txt"
  }
}


