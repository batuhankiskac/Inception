COMPOSE = docker compose -f ./srcs/docker-compose.yml
DATA_PATH = /home/bkiskac/data

all:
	mkdir -p $(DATA_PATH)/mariadb
	mkdir -p $(DATA_PATH)/wordpress
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

fclean: down
	docker system prune -af --volumes
	sudo rm -rf $(DATA_PATH)

re: fclean all

.PHONY: all down fclean re
