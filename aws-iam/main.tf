provider "aws" {
	region = "eu-west-1"
}
resource "aws_iam_user" "user" {
	name = "cla"
	tags = {
		Description = "Technical Team Leader"
	}
}

resource "aws_iam_policy" "adminUser" {
	name = "AdminUsers"
	policy = file("admin-policy.json")
}

resource "aws_iam_user_policy_attachment" "attach-usrer-policy" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.adminUser.arn
}


