provider "aws" {
        region = "eu-west-1"
}

resource "aws_s3_bucket" "my-s3-bucket" {
  bucket = "my-tf-test-bucket-18022024"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_object" "my-pet-object" {
  bucket = aws_s3_bucket.my-s3-bucket.id
  key    = "pet.txt"
  source = "pet.txt"

}

data "aws_iam_group" "sapphire-group" {
  group_name = "project-sapphire-users"
}

resource "aws_s3_bucket_policy" "sapphire-policy" {
  bucket = aws_s3_bucket.my-s3-bucket.id
  policy = <<EOF
	{
    	"Statement": [
        	{
            	"Action": "*",
            	"Effect": "Allow",
            	"Resource": "arn:aws:s3::${aws_s3_bucket.my-s3-bucket.id}/*",
		"Principal": {
			"AWS": [
			  "${data.aws_iam_group.sapphire-group.arn}"
			]
		}
        	}
    	],
    	"Version": "2012-10-19"
	}
  EOF
}
