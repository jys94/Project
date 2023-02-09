resource "null_resource" "copy_ec2_keys" {
  depends_on = [module.ec2_public]  
  connection {
    type     = "ssh"
    host     = aws_eip.bastion_eip.public_ip    
    user     = "ec2-user"
    password = ""
    private_key = file("~/Instance-Access-Key.pem")
  }
  provisioner "file" {
    source      = "~/Instance-Access-Key.pem"
    destination = "/home/ec2-user/.ssh/id_rsa"
  }
  provisioner "remote-exec" {
    inline = [ "sudo chmod 400 /home/ec2-user/.ssh/id_rsa" ]
  }
}

resource "null_resource" "openssl_install" {
  depends_on = [module.ec2_public]
  connection {
    type     = "ssh"
    host     = aws_eip.bastion_eip.public_ip    
    user     = "ec2-user"
    password = ""
    private_key = file("~/Instance-Access-Key.pem")
  }
  provisioner "file" {
    source      = "${path.module}/openssl-install.sh"
    destination = "/tmp/openssl-install.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "cd /tmp",
      "chmod 700 openssl-install.sh",
      "./openssl-install.sh | sudo tee /var/log/openssl-1.1.1k-update-output.log > /dev/null",
      "rm -rf /tmp/openssl*"
    ]
  }
  provisioner "local-exec" {
    command = "echo 'ssh -o StrictHostKeyChecking=no ec2-user@${aws_eip.bastion_eip.public_ip}' > ${path.module}/ssh.sh"
  }
}