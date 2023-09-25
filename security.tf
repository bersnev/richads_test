###################################################################
# SSH Access key template. Key whould be generated first
###################################################################

resource "aws_key_pair" "main" {
  key_name   = local.common_name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDdSnv4/Rha+UakVu1+CATS5MHvBMHLQmICAbVUSY3i30VbhXhYhTHWhPN64QOXf/p85t090+g+fX6BP+Zavbddy9OE/ZI3GY0bqGFys2/b6pd6IdYDEusttVJ6u2BG3b0l6XT8Xa8Y7NYTaHNmiRnHLNoXuWqkLPgO9cb99Hl1w7VrVLKEj7VDOmd86qJpAqSDZAWEA+dTJV3tY82M484kdU3YoU2G3ETl75DZ7iQRnZRpvMVdSnP3Howz7+W5CGwJ7fjMw2gVhacshiu0idtOq5mBFxnnQjDnXSG1KB+/wA6uCU5NmV1LXfnnm8mkK1JSE4+T2NnypgSAfOxszIGN richads"
}

resource "aws_iam_role" "put_S3" {
  name = "put_S3"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "put_S3" {
  name = "put_S3"
  role = aws_iam_role.put_S3.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObjectAcl",
        "s3:PutObject",
        "s3:PutObjectVersionAcl"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::test-bucket-736y836t56/some/pach/*"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "put_S3" {
  name = "put_S3"
  role = aws_iam_role.put_S3.name
}

resource "aws_default_security_group" "default" {
  vpc_id = module.vpc.vpc_id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }
}

resource "aws_security_group" "public" {
  name   = "public-access-${local.common_name}"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "Public SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
