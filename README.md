# Projeto Anahelo - Sistema de Controle de Inventário

Este é o repositório principal do projeto **Anahelo**, um sistema completo de controle de inventário composto por uma **API (Back-end)**, uma **aplicação web (Front-end)** e uma **infraestrutura de deployment** baseada em Docker e AWS.

---

## Estrutura do Projeto

O projeto está dividido em três partes principais:

- **Back-end (API)**  
  https://github.com/KaiqueIvo04/api-inventory-control  
  Desenvolvido com **NestJS**, responsável pela lógica de negócio e persistência de dados.

- **Front-end (App)**  
  https://github.com/KaiqueIvo04/app-anahelo  
  Desenvolvido com **Nuxt 3**, responsável pela interface de usuário para gerenciamento do inventário.

- **Deployment**  
  https://github.com/KaiqueIvo04/deployment  
  Contém:
  - Infraestrutura como código (Terraform)
  - Orquestração com Docker Compose
  - Configuração de Nginx como proxy reverso

---

## Como Iniciar

Este projeto pode ser executado de duas formas:
- Provisionando a infraestrutura na AWS
- Executando localmente via Docker

---

## 🚀 Provisionando a Infraestrutura na AWS (Terraform)

A infraestrutura é criada utilizando **Terraform** e inclui:
- Instância EC2
- Security Groups
- IAM Roles e Policies
- Integração com Amazon ECR

---

### Pré-requisitos

- Terraform >= 1.5
- AWS CLI configurado (`aws configure`)
- Conta AWS ativa
- Docker e Docker Compose
- Chave SSH gerada localmente (não versionada)

---

### 🔐 Geração da chave SSH

Por segurança, as chaves SSH **não são versionadas no repositório**.

Gere a chave localmente antes de aplicar o Terraform:

    ssh-keygen -t ed25519 -f ./terraform/keys/terraform-ec2

Arquivos gerados:

    keys/
    ├── terraform-ec2
    └── terraform-ec2.pub

---

### 🏗️ Provisionando a infraestrutura

1. Acesse o diretório do Terraform:

       cd deployment/terraform

2. Inicialize o Terraform:

       terraform init

3. Valide os arquivos:

       terraform validate

4. Provisione a infraestrutura:

       terraform apply

Ao final, a instância EC2 será criada já com:
- Acesso SSH configurado
- IAM Role associada
- Permissão para pull de imagens do ECR

---

### 🔑 Acesso à EC2 via SSH

Após o `terraform apply`, utilize o IP público da instância:

    chmod 600 ./keys/terraform-ec2
    ssh -i ./keys/terraform-ec2 ec2-user@IP_PUBLICO

Para AMIs Ubuntu, utilize o usuário `ubuntu`.

---

## 🐳 Subindo o Sistema com Docker

Após acessar a EC2:

1. Clone o repositório de deployment:

       git clone https://github.com/KaiqueIvo04/deployment.git
       cd deployment

2. Crie o arquivo `.env`:

       cp .env.example .env

3. Suba os containers:

       docker compose up -d

A aplicação ficará disponível via Nginx na porta 80 da instância.

---

## 🧩 Execução Separada (Ambiente de Desenvolvimento)

Para rodar os serviços individualmente, consulte:

- API: https://github.com/KaiqueIvo04/api-inventory-control
- App: https://github.com/KaiqueIvo04/app-anahelo

---

## 📌 Observações Finais

Este projeto foi estruturado com foco em:
- Boas práticas DevOps
- Infraestrutura como código
- Segurança
- Escalabilidade
- Portabilidade
