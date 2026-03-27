import { PrismaClient } from "@prisma/client";
import dotenv from "dotenv";

dotenv.config();

const isDocker = process.env.NODE_ENV === "production";

const databaseUrl = isDocker
  ? process.env.DOCKER_DATABASE_URL
  : process.env.DATABASE_URL;

if (!databaseUrl) {
  throw new Error("Database URL não definida");
}

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: databaseUrl,
    },
  },
});
