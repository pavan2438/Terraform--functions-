terraform {
  backend "s3" {
    bucket = "devopsb38terraformstate"
    key    = "functions.tfstate"
    region = "us-east-1"
  }
}
