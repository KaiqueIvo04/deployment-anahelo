resource "aws_instance" "inventorycontrol_server" {
  ami                    = "ami-0f85876b1aff99dde"
  key_name               = aws_key_pair.terraform_ec2.key_name
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.inventorycontrol_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name // To use profile, roles and policies of IAM

  tags = {
    Name        = "inventorycontrol_server"
    Provisioned = "Terraform"
    Cliente     = "AnaHelo"
  }
}

## KEY-PAIR EC2
resource "aws_key_pair" "terraform_ec2" {
  key_name   = "terraform_ec2"
  public_key = file("./keys/terraform-ec2.pub")
}

## SECURITY GROUP EC2
resource "aws_security_group" "inventorycontrol_sg" {
  name   = "inventorycontrol_sg"
  vpc_id = "vpc-04f5073937b609f58" # Default vpc

  tags = {
    Name        = "inventorycontrol_server"
    Provisioned = "Terraform"
    Cliente     = "AnaHelo"
  }
}

## SECURITY GROUP ROLES EC2
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.inventorycontrol_sg.id
  ip_protocol       = "tcp"
  from_port         = 22 // port to ssh protocol
  to_port           = 22
  cidr_ipv4         = "45.175.218.191/32" // your ip
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.inventorycontrol_sg.id
  ip_protocol       = "tcp"
  from_port         = 80 // port to http protocol
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0" // to be accessible by all ips
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.inventorycontrol_sg.id
  ip_protocol       = "tcp"
  from_port         = 443 // port to https protocol
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0" // to be accessible by all ips
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbond" { // egress rule for EC2 to access internet 
  security_group_id = aws_security_group.inventorycontrol_sg.id
  ip_protocol       = -1          // For access to all protocols
  cidr_ipv4         = "0.0.0.0/0" // For access to all ips
}

// ####################################### IAM  EC2 #######################################

// PROFILE
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "inventorycontrol_ec2_profile"
  role = aws_iam_role.ec2_role.name
}

// ROLE
resource "aws_iam_role" "ec2_role" {
  name = "access_ecr_registry_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name        = "inventorycontrol_server"
    Provisioned = "Terraform"
    Cliente     = "AnaHelo"
  }
}

// POLICY
resource "aws_iam_role_policy" "ecr_readonly" {
  name = "access_ecr_registry_policy"
  role = aws_iam_role.ec2_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "ecr:GetLifecyclePolicy",
          "ecr:GetLifecyclePolicyPreview",
          "ecr:ListTagsForResource",
          "ecr:DescribeImageScanFindings"
        ],
        "Resource" : "*"
      }
    ]
  })
}
