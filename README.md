# Projeto Final - Boot Camp de DevOps - Instituto Atlântico

## Case: Infraestrutura Automática para a empresa ExploraViagem em AWS

### Desafio
A equipe de desenvolvimento do ExploraViagem precisava garantir que o site fosse rapidamente escalável para suportar aumento de tráfego, sem a necessidade de intervenção manual em servidores ou infraestrutura.
### Solução
A solução proposta envolve o uso de **Infraestrutura como Código (IaC)** e automação com **Terraform** e **AWS**, além de Dockerização e automação de deploy com **GitLab CI/CD**.

<div align="center">
<img src="https://github.com/user-attachments/assets/1a86884e-d068-4149-a6fa-de575c8e1702" width="550px" />
</div>

#### 1. **Provisionamento com Terraform**
Foi implementada uma infraestrutura na **AWS** utilizando os seguintes recursos:
- **EC2 (Elastic Compute Cloud):** Servidores para hospedar o site.
- **Elastic Load Balancer (ELB):** Balanceamento de carga para distribuir tráfego entre os servidores.
- **Auto Scaling:** Escalabilidade automática para ajustar a quantidade de instâncias EC2 conforme a demanda de tráfego.

#### 2. **Dockerização do Site**
- Facilidade no deploy.
- Controle de versões através de containers.

#### 3. **Automação de Deploy com GitLab CI/CD**
- Configuração de pipeline no **GitLab CI/CD** para realizar builds automáticos.
- Deploy contínuo do site, com push para o **GitLab Container Registry** e execução nos servidores **EC2**.

### Resultados
- **Escalabilidade automática:** A infraestrutura se adapta automaticamente à demanda de usuários sem necessidade de intervenção manual.
- **Agilidade no deploy:** O ciclo de vida do site é completamente automatizado, permitindo deploys rápidos e consistentes.
- **Maior estabilidade e redução de erros:** O processo de deploy automatizado garante que o site esteja sempre disponível e com menos falhas.

### Tecnologias Utilizadas
- **AWS (EC2, ELB, Auto Scaling)**
- **Terraform**
- **Docker**
- **GitLab CI/CD**

### Como Rodar o Projeto
1. Clone este repositório.
2. Execute o Terraform para provisionar a infraestrutura na AWS.
3. Configure o pipeline do GitLab para automação do build e deploy.

### Contribuições
Sinta-se à vontade para contribuir com sugestões ou melhorias no projeto.

### Link das aplicação:
- Site: [https://eduardowys.github.io/site-de-viagem/](https://eduardowys.github.io/Site-de-viagem-bt-DevOps/)
- Docker Hub: https://hub.docker.com/r/eduardow3s/demoday/tags
- Vídeo teste: https://drive.google.com/file/d/1EVtGPSZLD0aM2MyMILzeG5dzCVqzRN_K/view?usp=sharing
---
Projeto desenvolvido como parte do Boot Camp de DevOps do Instituto Atlântico.
