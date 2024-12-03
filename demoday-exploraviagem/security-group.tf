# Configuração do Security Group para Load Balancer (ALB) e EC2
resource "aws_security_group" "web_server_sg" {
  name        = "web-server-sg"
  description = "Allow incoming HTTP, HTTPS, and SSH connections."
  vpc_id      = aws_vpc.main.id

  # Permitir tráfego HTTP (porta 80) e HTTPS (porta 443) para o Load Balancer e EC2
  ingress {
    description = "HTTP to Load Balancer and EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS to Load Balancer and EC2"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Permitir tráfego SSH para EC2 (Somente para sua rede ou IP específico, ajuste conforme necessário)
  ingress {
    description = "SSH to EC2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Alterar para um IP específico se necessário
  }

  # Outbound: Permitir tráfego de saída para qualquer destino
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-server-sg"
  }
}
