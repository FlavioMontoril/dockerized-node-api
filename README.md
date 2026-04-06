# Node + Prisma + MySQL Docker Demo 🚀

Este projeto demonstra a **containerização profissional** de uma API Node.js utilizando **TypeScript**, **Prisma ORM** e **MySQL**. O foco principal é a eficiência, segurança e o uso de **Docker Multi-stage Builds** ultra-otimizados.

---

## 🛠 Tecnologias e Otimizações

- **Runtime:** Node.js 22 (Baseada em Alpine Linux para leveza).
- **Linguagem:** TypeScript.
- **ORM:** Prisma com geração automática de Client.
- **Banco de Dados:** MySQL 8.0.
- **Containerização:** Docker com estratégia de 3 estágios (Build, Deps e Runtime).
- **Gerenciador de Pacotes:** Yarn (com suporte a Corepack).

---

## 🏗️ Estratégia de Build (Multi-Stage)

A imagem Docker foi projetada para ser extremamente leve (reduzida de ~1GB para ~411MB) seguindo três etapas:

1.  **Stage 1 (Builder):** Instala todas as dependências (incluindo `devDependencies`), gera o Prisma Client e compila o TypeScript para JavaScript (`dist/`).
2.  **Stage 2 (Deps):** Instala apenas as `dependencies` de produção, garantindo que ferramentas como TypeScript e Compiladores não ocupem espaço na imagem final.
3.  **Stage 3 (Runtime):** Utiliza uma imagem **Alpine** limpa, copia apenas o código compilado e as dependências de produção, resultando em um container seguro e de inicialização rápida.

---

## 🚀 Como Executar

### 1. Requisitos
- Docker e Docker Compose instalados.
- Arquivo `.env` configurado (veja `.env.example`).

### 2. Configuração do Ambiente
Crie seu arquivo `.env` baseando-se no exemplo:
```bash
cp .env.example .env
```
*Nota: Certifique-se de que a `DOCKER_DATABASE_URL` utilize o host `mysql` para comunicação interna entre containers.*

### 3. Subindo a Aplicação
Para construir e iniciar os serviços:
```bash
docker-compose up --build
```

A API estará disponível em: `http://localhost:4002` (ou a porta definida no seu `.env`).

---

## 🔍 Comandos Úteis

- **Rebuild sem cache (Recomendado após mudanças estruturais):**
  ```bash
  docker-compose build --no-cache api
  ```
- **Verificar logs:**
  ```bash
  docker-compose logs -f api
  ```
- **Executar Migrations (Dentro do container):**
  ```bash
  docker-compose exec api yarn prisma migrate deploy
  ```

---

## 🛡️ Segurança e Performance
- **Imagens Slim/Alpine:** Redução drástica da superfície de ataque e do consumo de disco.
- **User Rootless (Opcional):** A imagem está preparada para execução otimizada no ecossistema Node.
- **Healthchecks:** O Docker Compose aguarda o MySQL estar 100% pronto antes de iniciar a API.

---
*Desenvolvido por Flávio Montoril*
