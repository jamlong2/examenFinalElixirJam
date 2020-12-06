provider "aws" {
	region = var.region
	profile = "default"
}

resource "aws_instance" "instance" {
	ami 				= var.ami_small
	instance_type		= var.instance_small
	key_name = "keyjamtest3"
	
		tags = {
			Name = "EC2 Julian Marin"
		}
		
		vpc_security_group_ids =[
			aws_security_group.security_g.id
		]
}

resource "aws_db_instance" "db" {
	allocated_storage = 20
	storage_type = "gp2"
	engine = "mysql"
	engine_version = "5.7"
	instance_class = "db.t2.micro"
	name = "name"
	username = "username"
	password = "password"
	parameter_group_name = "default.mysql5.7"
	skip_final_snapshot = true
}

resource "aws_security_group" "security_g"{
    name = "security group iex_jam"
    ingress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "SSH"
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

resource "aws_iam_user" "user" {
	name = "user"
	path = "/system/"
}

resource "aws_iam_access_key" "user" {
	user = aws_iam_user.user.name
}

resource "aws_iam_user_policy" "user_policy"{
	name = "user_policy"
	user = aws_iam_user.user.name
	policy = data.aws_iam_policy_document.user_policy_document.json
}

data "aws_iam_policy_document" "user_policy_document"{
	statement{
		sid = "1"

		actions = [
			"ec2:*",
			"rds:*"
		]

		resources = [
			aws_instance.instance.arn,
			aws_db_instance.db.arn
		]
	}
}


