### SSH key pair
To access the Linux based EC2 instance via SSH, you'll need a SSH key pair.
Run the command `ssh-keygen -t rsa -b 4096` to create a new RSA key pair with the length of 4096 bits.

then use the public key in the main.tf file, as for example

```terraform
resource "aws_key_pair" "web" {
        public_key = file("/home/aborraccino/.ssh/id_rsa/aws-ec2.pub")
}
```

Once the EC2 instance is created access to the remote machine run the command ``ssh -i /home/aborraccino/.ssh/id_rsa/aws-ec2 ubuntu@<public-ip>``
