resource "aws_s3_bucket" "devopsb30testbuk002" {
  bucket = "devopsb30testbuk001"
  tags = {
    Name = "devopsb30testbuk001"
  }
}