resource "null_resource" "cluster" {
  count = local.newenv == "Dev" || local.newenv == "dev" ? 3 : 1
  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("DeleteLater.pem")
      host        = element(aws_instance.public_servers.*.public_ip, count.index)
    }
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/script.sh",
      "sudo /tmp/script.sh",
      "sudo apt update ",
      "sudo useradd -m ansibleadmin --shell /bin/bash",
      "sudo mkdir -p /home/ansibleadmin/.ssh",
      "sudo chown -R ansibleadmin /home/ansibleadmin/",
      "sudo touch /home/ansibleadmin/.ssh/authorized_keys",
      "sudo usermod -aG sudo ansibleadmin",
      "echo 'ansibleadmin ALL=(ALL) NOPASSWD: ALL' | sudo tee -a /etc/sudoers"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("DeleteLater.pem")
      #host     = "${aws_instance.web-1.public_ip}"
      host = element(aws_instance.public_servers.*.public_ip, count.index)
    }
  }
#   provisioner "local-exec" {
#     command = <<EOH
#        echo "${element(aws_instance.public_servers.*.public_ip, count.index)}" >> public_server_details_1 && echo "${element(aws_instance.public_servers.*.private_ip, count.index)}" >> private_server_details_2,
#       EOH
  }
