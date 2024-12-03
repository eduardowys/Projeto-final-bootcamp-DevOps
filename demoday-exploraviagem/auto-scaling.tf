# Launch Template para instâncias EC2
resource "aws_launch_template" "web_server_template" {
  name          = "web-server-launch-template"    # Nome do Launch Template
  instance_type = "t2.micro"                      # Tipo de instância EC2
  image_id      = "ami-0a0e5d9c7acc336f1"         # ID da AMI a ser utilizada
  key_name      = "terraformaws"                  # Nome do Key Pair
  user_data     = base64encode(file("script.sh")) # Script de inicialização

  # Configuração de rede e segurança
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.web_server_sg.id] # Referência ao Security Group
  }

  # Tags para a instância
  tags = {
    Name        = "explora-viagem" # Nome da instância
    Environment = "production"     # Ambiente de produção
    Project     = "ExploraViagem"  # Nome do projeto
  }
}

# Auto Scaling Group para gerenciar as instâncias EC2
resource "aws_autoscaling_group" "web_server_asg" {
  name                      = "web-server-autoscaling-group" # Nome do Auto Scaling Group
  max_size                  = 2                              # Máx. de instâncias
  min_size                  = 1                              # Mín. de instâncias
  desired_capacity          = 1                              # Capacidade inicial
  health_check_grace_period = 60                             # Tempo de verificação de saúde (1 min)
  health_check_type         = "ELB"
  vpc_zone_identifier       = [aws_subnet.public1.id, aws_subnet.public2.id] # Subnets públicas onde as instâncias serão lançadas

  launch_template {
    id      = aws_launch_template.web_server_template.id # Referência ao Launch Template criado
    version = "$Latest"                                  # Usar a versão mais recente do template
  }

  target_group_arns = [aws_lb_target_group.web_server_target_group.arn] # Vinculação ao Target Group do Load Balancer

  force_delete = true # Forçar a exclusão do Auto Scaling Group ao destruir o recurso

  # Adicionando Tags
  tag {
    key                 = "Name"
    value               = "explora-viagem-instance" # Nome com índice para instâncias escalonadas
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "production"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = "ExploraViagem"
    propagate_at_launch = true
  }
}

# Política de escalonamento para ajustar o número de instâncias com base no uso de CPU (única política de TargetTracking)
resource "aws_autoscaling_policy" "scale_up_down" {
  name                   = "scale-up-down-policy"                    # Nome da política de aumento e redução de instâncias
  autoscaling_group_name = aws_autoscaling_group.web_server_asg.name # Referência ao Auto Scaling Group

  policy_type = "TargetTrackingScaling" # Tipo de política Target Tracking

  target_tracking_configuration {
    target_value = 60 # Valor alvo para a utilização média de CPU (abaixo -1, aumento +1 instance)
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization" # Métrica para a CPU média das instâncias
    }
  }
}
