#!/bin/bash
yum update -y

  # Install Docker
yum install -y docker
systemctl start docker
systemctl enable docker
sudo usermod -s /bin/bash jenkins
sudo usermod -aG docker jenkins
echo "jenkins ALL=(ALL) NOPASSWD: $(which docker)" | sudo tee /etc/sudoers.d/jenkins



sudo yum install git -y

rpm --import https://yum.corretto.aws/corretto.key
curl -Lo /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
yum install -y java-17-amazon-corretto


wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
curl -fsSL https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key | sudo tee /etc/pki/rpm-gpg/jenkins.io.key
sudo rpm --import /etc/pki/rpm-gpg/jenkins.io.key
yum install -y jenkins

systemctl enable jenkins
systemctl start jenkins

reboot