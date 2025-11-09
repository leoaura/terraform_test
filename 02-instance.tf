# 키페어 생성 (이미 로컬에 키가 있다면 file()로 대체)
resource "aws_key_pair" "default" {
  key_name   = "terraform-key"
  public_key = file("./id_rsa.pub")
}

# 보안그룹 (SSH, ICMP, HTTP 허용)
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow SSH, ICMP, HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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

# EC2 인스턴스 생성
resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = aws_key_pair.default.key_name

  root_block_device {
    volume_type = "gp3"      # 부팅용은 gp3가 안전/저렴
    volume_size = 8          # 최소 크기(8GiB)
    # iops/throughput 미설정 → 기본(추가 요금 없음)
    encrypted   = true
    delete_on_termination = true
  }

  tags = {
    Name = var.tag_name
  }
}

