variable "region" {
  default = "ap-northeast-2"
}

variable "profile" {
  default = "default"
}
variable "ami_id" {
  # Amazon Linux 2 (서울 리전 예시)
  #default = "ami-01ff6f23cfef6c4b1"
  default = "ami-02dba2170b14cd02a"
}

variable "tag_name" {
}


variable "instance_type" {
  #default = "t3.micro"
}
