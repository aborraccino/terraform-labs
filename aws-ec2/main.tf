provider "aws" {
        region = "eu-west-1"
}

resource "aws_instance" "webserver" {
        ami = "ami-0776c814353b4814d"
        instance_type = "t2.micro"
        tags = {
                Name = "webserver"
                Description = "An Ngnix WebServer on Ubuntu"
        }
        user_data = <<-EOF
        sudo apt update
        sudo apt install ngnix -y
        systemctl enable ngnix
        systemctl start ngnix
        EOF

        key_name = aws_key_pair.web.id
        vpc_security_group_ids = [ aws_security_group.ssh-access.id ]
}

resource "aws_key_pair" "web" {
        public_key = file("/home/aborraccino/.ssh/id_rsa/aws-ec2.pub")
}

resource "aws_security_group" "ssh-access" {
        name = "ssh-access"
        description = "Allow SSH access from the internet"
        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }
}

output publicip {
        value = aws_instance.webserver.public_ip
}