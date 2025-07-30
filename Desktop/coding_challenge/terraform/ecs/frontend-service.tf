resource "aws_ecs_service" "frontend_service" {
  name            = "frontend-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.frontend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.frontend_tg.arn
    container_name   = "frontend"  
    container_port   = 3000        
  }

  network_configuration {
    assign_public_ip = true
    subnets          = [aws_subnet.ecs_subnet.id]
    security_groups  = [aws_security_group.frontend_security_group.id]
  }

 
  force_new_deployment = true

  depends_on = [
    aws_ecs_cluster.my_cluster,
    aws_ecs_task_definition.frontend,
    aws_lb_listener.frontend_listener  
  ]
}
