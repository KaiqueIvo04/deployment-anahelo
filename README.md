# Projeto Anahelo - Sistema de Controle de Inventário

Este é o repositório principal do projeto Anahelo, um sistema completo de controle de inventário composto por uma API (Back-end), uma aplicação web (Front-end) e orquestração para implantação.

## Estrutura do Projeto

O projeto está dividido em três partes principais:

- **[Back-end (API)](https://github.com/KaiqueIvo04/api-inventory-control):** Desenvolvido com NestJS, responsável pela lógica de negócio e persistência de dados.
- **[Front-end (App)](https://github.com/KaiqueIvo04/app-anahelo):** Desenvolvido com Nuxt 3, interface de usuário para gerenciamento do inventário.
- **[Deployment](https://github.com/KaiqueIvo04/deployment):** Configurações de Docker Compose e Nginx para subir todo o ambiente de forma orquestrada.

## Como Iniciar

### Subindo o sistema completo (Docker)

A maneira mais rápida de rodar todo o sistema (API, Web App, Banco de Dados e Proxy Reverso) é utilizando o Docker Compose:

1. Navegue até a pasta de deployment:
   ```bash
   cd deployment
   ```
2. Crie um arquivo `.env` baseado no `.env.example`:
   ```bash
   cp .env.example .env
   ```
3. Inicie os containers:
   ```bash
   docker compose up -d
   ```
O sistema estará disponível em `http://localhost`.

### Rodando separadamente

Para instruções detalhadas de como rodar cada parte do sistema de forma independente para desenvolvimento, consulte os READMEs específicos:
- [Instruções do Back-end](https://github.com/KaiqueIvo04/api-inventory-control/README.md)
- [Instruções do Front-end](https://github.com/KaiqueIvo04/app-anahelo/README.md)
