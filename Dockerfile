# ------------------------------------- Simples Desenvolvimento --------------------------

# FROM node:22-slim

# RUN apt-get update \
#     && apt-get install -y openssl \
#     && rm -rf /var/lib/apt/lists/*

# WORKDIR /app

# COPY package*.json yarn.lock ./

# RUN corepack enable

# RUN yarn install --frozen-lockfile

# COPY . .

# RUN yarn prisma generate

# EXPOSE 4002

# CMD ["yarn", "start:prod"]

# ------------------------------------- Multi Stage -------------------------------------
# Stage 1
FROM node:22-slim as builder

WORKDIR /app

COPY package*.json yarn.lock ./

RUN apt-get update -y && apt-get install -y openssl && rm -rf /var/lib/apt/lists/*
RUN corepack enable && yarn install --frozen-lockfile

COPY . .

RUN yarn prisma generate
RUN yarn build

# Stage 2
FROM node:22-slim

RUN apt-get update -y && apt-get install -y openssl && rm -rf /var/lib/apt/lists/*

# Copia apenas o necessário do builder
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/prisma ./prisma

EXPOSE 4002

CMD [ "node", "dist/index.js" ]

