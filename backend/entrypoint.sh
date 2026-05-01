#!/bin/sh

# Si le projet Nest n'existe pas, on le crée
if [ ! -f "package.json" ]; then
    echo "📦 Initialisation NestJS..."
    npx @nestjs/cli new . --package-manager npm --skip-git
fi

# Si Prisma n'est pas initialisé, on le fait
if [ ! -d "prisma" ]; then
    echo "💎 Initialisation Prisma..."
    npm install prisma --save-dev
    npm install @prisma/client
    npx prisma init
fi

# Installation des dépendances
npm install

# On lance la synchronisation (création des tables dans Postgres)
echo "🔄 Synchronisation de la DB..."
npx prisma db push

# Lancement de l'app
npm run start:dev