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
  policy = data.aws_iam_policy_document.sapphire-policy.json
}

data "aws_iam_policy_document" "sapphire-policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [data.aws_iam_group.sapphire-group.arn]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.my-s3-bucket.arn
    ]
  }
}
