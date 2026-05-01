#!/bin/sh

if [ ! -f "package.json" ]; then
    echo "📦 Création du projet Vite (méthode Ninja)..."
    
    # 1. On crée le projet dans un dossier temporaire appelé "temp_app"
    npx --yes create-vite@latest temp_app --template react-ts
    
    # 2. On déplace tout le contenu de temp_app vers le dossier courant (.)
    # Le cp copie les fichiers normaux (*) et les fichiers cachés (.[!.]*)
    cp -r temp_app/* temp_app/.[!.]* . 2>/dev/null || true
    
    # 3. On supprime le dossier temporaire
    rm -rf temp_app
    
    echo "✅ Fichiers Vite générés avec succès !"
fi

echo "📥 Installation des dépendances..."
npm install

echo "🚀 Lancement de Vite..."
npm run dev -- --host 0.0.0.0