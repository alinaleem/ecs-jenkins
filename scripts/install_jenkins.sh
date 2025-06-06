#!/bin/bash
set -e

echo "🔄 Updating system..."
sudo yum update -y

echo "☕ Installing Java 17 (Amazon Corretto)..."
sudo rpm --import https://yum.corretto.aws/corretto.key
sudo curl -Lo /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
sudo yum install -y java-17-amazon-corretto-devel

echo "🧰 Installing Git..."
sudo yum install -y git

echo "➕ Adding Jenkins repo..."
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

echo "🔧 Installing Jenkins..."
sudo yum install -y jenkins

echo "🐳 Installing Docker..."
sudo yum install -y docker
sudo systemctl enable docker
sudo systemctl start docker

echo "🚀 Enabling and starting Jenkins..."
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "👷 Adding Jenkins user to Docker group..."
sudo usermod -aG docker jenkins

echo "🔐 Setting Docker socket permissions..."
sudo chown root:docker /var/run/docker.sock
sudo chmod 660 /var/run/docker.sock

echo "♻️ Restarting Jenkins to apply group changes..."
sudo systemctl restart jenkins

echo "✅ Jenkins, Docker, Java 17, and Git installed successfully!"
