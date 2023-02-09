MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"


#!bin/bash

# install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v${RELEASE}.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
chown ec2-user:ec2-user ./kubectl
mkdir -p /home/ec2-user/bin/
sudo mv ./kubectl /home/ec2-user/bin/kubectl
kubectl version

# Change Docker Permission for Jenkins
sudo chmod 666 /var/run/docker.sock


--==MYBOUNDARY==--