resource "aws_ecs_task_definition" "backend" {
  family                   = "backend"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"  # Adjust based on your needs
  memory                   = "1024"  # Adjust based on your needs
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "backend"
      image     = "289953284546.dkr.ecr.us-east-1.amazonaws.com/my-application-repo:backend" # Update with your ECR image URI
      cpu       = 512
      memory    = 1024
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
          protocol      = "tcp"
        },
      ],
      environment = [
        {
          name  = "NODE_ENV"
          value = "production"
        },
      ],
    }
  ])
}
