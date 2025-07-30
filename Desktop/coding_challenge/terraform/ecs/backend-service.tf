resource "aws_ecs_service" "backend_service" {
  name            = "backend-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.backend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    assign_public_ip = false  
    subnets          = [aws_subnet.ecs_private_subnet.id]
    security_groups  = [aws_security_group.backend_security_group.id]
  }

  depends_on = [
    aws_ecs_cluster.my_cluster,
    aws_ecs_task_definition.backend
  ]
}
