resource "local_file" "foo" {
  content = "Welcome To DevOps Training In Telugu..!!!\nWelcome To DevOps Training In Telugu..!!!\nWelcome To DevOps Training In Telugu..!!!\nWelcome To DevOps Training In Telugu..!!!\nWelcome To DevOps Training In Telugu..!!!"

  filename = "${path.module}/welcome.log"
}

resource "local_file" "ip" {
  content = templatefile("details.tpl",
    {

      server01_public_ip  = aws_instance.public_servers.0.public_ip
      server01_private_ip = aws_instance.public_servers.0.private_ip
      vpc_id              = aws_vpc.default.id
      public_subnet1_id   = aws_subnet.public-subnets.0.id
      public_subnet2_id   = aws_subnet.public-subnets.1.id
      public_subnet3_id   = aws_subnet.public-subnets.2.id
    }
  )
  filename = "invfile"
}

resource "local_file" "inventory-file" {
  content = templatefile("ansible.tpl",
    {

      testserver01    = aws_instance.public_servers.0.public_ip
      testserver02    = aws_instance.public_servers.1.public_ip
      testserver03    = aws_instance.public_servers.2.public_ip
      pvttestserver01 = aws_instance.public_servers.0.private_ip
      pvttestserver02 = aws_instance.public_servers.1.private_ip
      pvttestserver03 = aws_instance.public_servers.2.private_ip
    }
  )
  filename = "ansible-invfile"
}