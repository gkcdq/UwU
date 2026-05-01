# Variables
DOCKER_COMPOSE = docker-compose

# Couleurs pour le terminal
BLUE = \033[1;34m]
NC = \033[0m]

.PHONY: all build up down clean restart logs shell-back shell-db

all: build up

# Construit les images
build:
	@echo "$(BLUE)🏗️  Construction des images Docker...$(NC)"
	$(DOCKER_COMPOSE) build

# Lance les containers en arrière-plan
up:
	@echo "$(BLUE)🚀 Lancement des containers...$(NC)"
	$(DOCKER_COMPOSE) up 
	@echo "$(BLUE)💡 Astuce : Tape 'make logs' pour voir l'installation progresser.$(NC)"

# Arrête les containers
down:
	@echo "$(BLUE)🛑 Arrêt des services...$(NC)"
	$(DOCKER_COMPOSE) down

# Relance tout (utile si tu changes le entrypoint.sh)
restart: down up

# Affiche les logs en temps réel
logs:
	$(DOCKER_COMPOSE) logs -f

# Nettoyage complet (Supprime les containers, les images orphelines et les volumes)
# Attention : cela réinitialise ta base de données !
# ... reste du fichier au dessus ...

DOCKER_CLEAN = docker run --rm -v $(PWD):/system alpine sh -c

clean:
	@echo "🧹 Nettoyage des fichiers protégés via Docker..."
	# Arrête les containers et les volumes
	docker-compose down -v --remove-orphans
	
	# Suppression des dossiers node_modules et dist sans sudo
	$(DOCKER_CLEAN) "rm -rf /system/backend/node_modules /system/backend/dist /system/backend/package-lock.json"
	$(DOCKER_CLEAN) "rm -rf /system/frontend/node_modules /system/frontend/dist /system/frontend/package-lock.json"
	
	@echo "✨ Clean completed !"

fclean:
	@echo "🧨 Purge des fichiers d'installation (en gardant src/)..."
	docker-compose down -v --remove-orphans
	
	$(DOCKER_CLEAN) "rm -rf /system/backend/node_modules /system/backend/dist /system/backend/package-lock.json /system/backend/test /system/backend/package.json /system/backend/tsconfig*.json /system/backend/nest-cli.json /system/backend/eslint.config.mjs /system/backend/.prettierrc"

	$(DOCKER_CLEAN) "rm -rf /system/frontend/node_modules /system/frontend/dist /system/frontend/package-lock.json /system/frontend/public /system/frontend/package.json /system/frontend/tsconfig*.json /system/frontend/vite.config.ts /system/frontend/eslint.config.js /system/frontend/index.html"
	
	@echo "✨ fclean completed."

# Accéder au terminal du backend (pratique pour lancer des commandes prisma)
shell-back:
	docker exec -it C_backend sh

# Accéder à la console PostgreSQL
shell-db:
	docker exec -it uwu-db-1 psql -U user -d task_db

# Corriger les permissions des fichiers créés par Docker sur ta VM
fix-perms:
	@echo "$(BLUE)🔐 Correction des permissions (sudo requis)...$(NC)"
	sudo chown -R $(USER):$(USER) .