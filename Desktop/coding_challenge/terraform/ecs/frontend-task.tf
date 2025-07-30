resource "aws_ecs_task_definition" "frontend" {
  family                   = "frontend"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"  
  memory                   = "1024"  
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "frontend"
      image     = "289953284546.dkr.ecr.us-east-1.amazonaws.com/my-application-repo:frontend"  # Update with your actual ECR image URI
      cpu       = 512
      memory    = 1024
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
        },
      ],
environment = [
    {
        name  = "NODE_ENV"
        value = "production"
    },
]
    }
  ])
}
