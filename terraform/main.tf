# provider

provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

# provider
resource "aws_key_pair" "login_key" {
  key_name   = var.keypair_name
  public_key = file("login_key.pub")                # change filename incase you are created key with different name
}


# resources

resource "aws_instance" "this" {
  ami                    = var.ami
  availability_zone      = var.availability_zone
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group
  subnet_id              = var.subnet_id
  user_data              = file("install_script.sh")
  iam_instance_profile   = var.iam_instance_profile
  tags                   = merge(map("Name", "instance"), var.extra_tags)

  depends_on = [aws_key_pair.login_key]
}

# variables

variable "access_key" {
  type = string
  description = "(optional) access key"
  default = ""
}

variable "secret_key" {
  type = string
  description = "(optional) secret key"
  default = ""
}

variable "region" {
    type = string
    description = "(optional) region"
    default = ""
}

variable "availability_zone" {
  type    = string
  default = ""
}

variable "ami" {
  type        = string
  description = "(optional) ami id to provision ec2 instance"
  default     = ""
}

variable "instance_type" {
  type        = string
  description = "(optional) instance type"
  default     = "t2.micro"
}

variable "key_name" {
  type        = string
  description = "(optional) key_pair name for login"
  default     = ""
}

variable "security_group" {
  type        = list
  description = "(optional) give specific sg to add to instance"
  default     = []
}

variable "subnet_id" {
  type        = string
  description = "(optional) subnet id to provision instance in particular subnet"
  default     = ""
}

variable "iam_instance_profile" {
  type        = string
  description = "(optional) iam role, add to instance"
  default     = ""
}

variable "extra_tags" {
  type        = map(any)
  description = "(optional) extra tags to add"
  default     = {}
}

variable "keypair_name" {
    type = string
    description = "(optional) key pair name"
    default = "login_key"
}

# outputs


output "instance_id" {
  value = aws_instance.this.id
}

output "public_dns" {
  value = aws_instance.this.public_dns
}

output "public_ip" {
  value = aws_instance.this.public_ip
}

output "instance_state" {
  value = aws_instance.this.instance_state
}