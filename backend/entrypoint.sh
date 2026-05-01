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
npm install
npm install @prisma/config

# 2. Génération Prisma et Push
npx prisma generate
echo "🔄 Synchronisation de la DB..."
npx prisma db push

# 3. LE PLUS IMPORTANT : On déverrouille TOUT juste avant de lancer
# On le fait après les installs pour que node_modules soit aussi inclus
chmod -R 777 /usr/src/app

# 4. Lancement de l'app
npm run start:dev