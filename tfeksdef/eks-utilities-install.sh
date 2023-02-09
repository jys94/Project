#!bin/bash

# install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
mv /tmp/eksctl /usr/local/bin/

# install awscli >= v2.0
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
rm -rf awscliv2.zip
./aws/install
aws --version

# install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v${RELEASE}.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
sudo ln -s /usr/local/bin/kubectl /usr/bin
kubectl version

# install docker
amazon-linux-extras install docker
usermod -a -G docker ec2-user
systemctl enable --now docker
docker version

# install terraform, git
yum install -y git yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
yum -y install terraform
cp /usr/bin/terraform /usr/local/bin/
terraform version
git version

# awscli, kubectl. terraform command autocomplete
echo "complete -C '/usr/local/bin/aws_completer' aws" >> /etc/bashrc
echo "source <(kubectl completion bash)" >> /etc/bashrc
echo "complete -C /usr/local/bin/terraform terraform" >> /etc/bashrc