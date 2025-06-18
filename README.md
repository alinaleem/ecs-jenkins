# 📦 ECS-Jenkins Hello World App (EC2 Launch Type)

This project provisions an **ECS Cluster (EC2 launch type)** that runs a **Dockerized Python app** with full CI/CD automation using **Jenkins**, **Terraform**, and **AWS ECS**.

---

## 🧰 Tech Stack

- ⚙️ **Terraform** – Infrastructure as Code
- 🐳 **Docker** – App containerization
- 🚀 **Amazon ECS (EC2)** – Container orchestration
- 📦 **Amazon ECR** – Image storage
- 🔧 **Application Load Balancer** – Routing
- 🤖 **Jenkins** – CI/CD automation

---

## 🏗️ Architecture

![AWS Architecture Diagram](./images/Architecture.webp)

---

## 🔨 Key Components

- **Terraform Modules**:
  - VPC, ECS Cluster, ALB, IAM, ASG
- **hello-world-app/**:
  - Python app, Dockerfile, Jenkinsfile
- **Jenkins Pipeline**:
  - Clones repo → Builds image → Pushes to ECR → Updates ECS

---

## 🚀 How to Deploy

```bash
git clone https://github.com/alinaleem/ecs-jenkins.git
cd ecs-jenkins
terraform init
terraform apply -auto-approve
```

> Output will include your ALB DNS URL

---

## 🌐 Access the App

```bash
curl http://<ALB_DNS>
```

Or open:

```
http://<alb-dns>.amazonaws.com
```

---

## 🔄 CI/CD Flow

1. Jenkins clones the GitHub repo
2. Builds & tags Docker image
3. Pushes to Amazon ECR
4. Updates ECS Service using `aws ecs update-service`

---

## 🧹 Teardown

```bash
terraform destroy -auto-approve
```

---

## 🙋‍♂️ Author

Made with ❤️ by [@alinaleem](https://github.com/alinaleem)  
Let’s connect on [LinkedIn](https://linkedin.com/in/alinaleem)
