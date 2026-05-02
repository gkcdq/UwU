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

DOCKER_CLEAN = docker run --rm -v $(shell pwd):/system alpine sh -c

clean:
	@echo "🧹 Nettoyage des fichiers protégés via Docker..."
	# Arrête les containers et les volumes
	docker-compose down
	
	# Suppression des dossiers node_modules et dist sans sudo
	$(DOCKER_CLEAN) "rm -rf /system/backend/dist"
	$(DOCKER_CLEAN) "rm -rf /system/frontend/dist"
	
	@echo "✨ Clean completed !"

fclean:
	@echo "🧨 Purge des dépendances et du build (Code source préservé)..."
	docker-compose down -v --remove-orphans
	# On ne touche SURTOUT PAS au package.json ni au dossier src/
	$(DOCKER_CLEAN) "rm -rf /system/backend/dist"
	$(DOCKER_CLEAN) "rm -rf /system/frontend/dist"
	@echo "✨ fclean terminé. Tes fichiers sont en sécurité."

# Accéder au terminal du backend (pratique pour lancer des commandes prisma)
shell-back:
	docker exec -it C_backend sh

# Accéder à la console PostgreSQL
shell-db:
	docker exec -it uwu-db-1 psql -U user -d task_db

unlock:
	@echo "$(BLUE)🔓 Déverrouillage des permissions (chmod 777)...$(NC)"
	# On utilise -d pour ne pas bloquer le terminal si les containers tournent
	docker exec C_backend chmod -R 777 /usr/src/app || true
	docker exec C_frontend chmod -R 777 /usr/src/app || true