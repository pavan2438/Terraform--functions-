# resource "aws_db_subnet_group" "default" {
#   name       = "devopsb31subnetgroup"
#   subnet_ids = [aws_subnet.public-subnets.0.id, aws_subnet.public-subnets.1.id, aws_subnet.public-subnets.2.id]
#   tags = {
#     Name = "devopsb31subnetgroup"
#   }
# }

# #Importing DB Secrets From Secret Manager
# data "aws_secretsmanager_secret_version" "creds" {
#   secret_id = "db-creds"
# }

# locals {
#   db_creds = jsondecode(
#     data.aws_secretsmanager_secret_version.creds.secret_string
#   )
# }

# resource "aws_db_instance" "myrds4" {
#   allocated_storage    = 10
#   identifier           = "myrds4" #Uncomment This Before Deploying.
#   engine               = "MySQL"
#   engine_version       = "8.0.28"
#   instance_class       = "db.t3.micro"
#   db_name              = "datebase-1"
#   db_subnet_group_name = aws_db_subnet_group.default.name
#   # Manually Created secrets from AWS Secrets Manager
#   username = local.db_creds.username
#   password = local.db_creds.password
#   #final_snapshot_identifier = true
#   skip_final_snapshot    = true
#   publicly_accessible    = true
#   vpc_security_group_ids = [aws_security_group.allow_all.id]
#   depends_on             = [aws_db_subnet_group.default]
#   lifecycle {
#     prevent_destroy = false
#     ignore_changes  = [tags, ]

#   }
# }`