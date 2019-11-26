variable "AWS_REGION" {
  default = "us-west-2"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "my-key-pair"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "my-key-pair.pub"
}

variable "RDS_PASSWORD" {
}

# Amazon Linux 2 machine images
variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-00068cd7555f543d5"
    us-west-2 = "ami-0c5204531f799e0c6"
    eu-west-1 = "ami-01f14919ba412de34"
    ap-southeast-1 = "ami-07539a31f72d244e7"
  }
}
