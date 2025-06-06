resource "aws_ecr_repository" "repo" {
  name = var.repo_name

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = var.repo_name
  }
}

resource "aws_ecr_repository_policy" "jenkins_push_policy" {
  repository = aws_ecr_repository.repo.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowJenkinsEC2ToPush",
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::827327671383:role/jenkins-ec2-role"
        },
        Action = [
          "ecr:GetAuthorizationToken", # 🔥 ADD THIS
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ]
      }
    ]
  })
}
