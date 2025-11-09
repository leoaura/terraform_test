# EIP 생성 (VPC용)
resource "aws_eip" "web_eip" {
  domain = "vpc"
  tags = { Name = "web-eip" }
}

# EIP를 인스턴스에 연결
resource "aws_eip_association" "web_eip_assoc" {
  instance_id   = aws_instance.web.id
  allocation_id = aws_eip.web_eip.id
}
