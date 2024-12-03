# Application Load Balancer (ALB)
resource "aws_lb" "web_server_lb" {
  name                             = "web-server-load-balancer"                     # Nome do Load Balancer
  internal                         = false                                          # Load Balancer externo
  load_balancer_type               = "application"                                  # Tipo de LB (ALB)
  security_groups                  = [aws_security_group.web_server_sg.id]          # Security Group associado
  subnets                          = [aws_subnet.public1.id, aws_subnet.public2.id] # Subnets públicas
  enable_deletion_protection       = false                                          # Permite exclusão do LB
  enable_cross_zone_load_balancing = true                                           # Balanceamento entre zonas

  tags = {
    Name        = "web-server-load-balancer" # Nome do ALB
    Environment = "production"               # Ambiente de produção
    Project     = "ExploraViagem"            # Nome do projeto
  }
}

# Target Group para o Load Balancer
resource "aws_lb_target_group" "web_server_target_group" {
  name     = "web-server-target-group" # Nome do Target Group
  port     = 80                        # Porta do serviço
  protocol = "HTTP"                    # Protocolo
  vpc_id   = aws_vpc.main.id           # VPC onde o Load Balancer e servidores estão

  health_check {
    protocol            = "HTTP" # Protocolo para Health Check
    port                = "80"   # Porta para Health Check
    path                = "/"    # Caminho para verificar a saúde
    interval            = 30     # Intervalo entre verificações (segundos)
    timeout             = 5      # Tempo limite para resposta (segundos)
    healthy_threshold   = 3      # Número de verificações saudáveis consecutivas necessárias
    unhealthy_threshold = 5      # Número de verificações malsucedidas consecutivas necessárias
  }

  tags = {
    Name        = "web-server-target-group" # Nome do Target Group
    Environment = "production"              # Ambiente de produção
    Project     = "ExploraViagem"           # Nome do projeto
  }
}

# Listener para o Load Balancer
resource "aws_lb_listener" "web_server_listener" {
  load_balancer_arn = aws_lb.web_server_lb.arn # Referência ao ALB
  port              = "80"                     # Porta para escutar
  protocol          = "HTTP"                   # Protocolo do listener

  default_action {
    type = "fixed-response" # Tipo de ação padrão
    fixed_response {
      status_code  = 200          # Código de resposta HTTP
      content_type = "text/plain" # Tipo de conteúdo da resposta
      message_body = "OK"         # Corpo da resposta
    }
  }
}