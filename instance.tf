resource "aws_instance" "server-1" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # The tags section is where AWS resources can be tagged using key value pairs
  tags = {
    Name = "server-1"
    map-migrated = ""
  }
  subnet_id = aws_subnet.tag-demo-public-1.id
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  key_name = aws_key_pair.mykeypair.key_name
}

resource "aws_ebs_volume" "vol-1" {
  availability_zone = "us-west-2a"
  size              = 20
  type              = "gp2"
  # The tags section is where AWS resources can be tagged using key value pairs
  tags = {
    Name = "vol-1"
    map-migrated = ""
  }
}

resource "aws_volume_attachment" "vol-1-attachment" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.vol-1.id
  instance_id = aws_instance.server-1.id
}
