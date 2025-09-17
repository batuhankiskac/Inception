COMPOSE_FILE := ./srcs/docker-compose.yaml
COMPOSE := docker compose -f $(COMPOSE_FILE)

LOGIN ?= $(shell id -un)

DATA_ROOT := /home/$(LOGIN)/data
WP_DIR := $(DATA_ROOT)/wordpress_files
DB_DIR := $(DATA_ROOT)/mariadb_data


all: up

prepare-dirs:
	@mkdir -p "$(WP_DIR)"
	@mkdir -p "$(DB_DIR)"

up: prepare-dirs
	@echo "Starting Inception project..."
	$(COMPOSE) up --build -d

down:
	@echo "Stopping Inception project..."
	$(COMPOSE) down

logs:
	$(COMPOSE) logs -f

clean:
	@echo "Cleaning all Inception data..."
	$(COMPOSE) down --volumes --rmi all
	docker system prune -af
	@rm -rf "$(WP_DIR)" "$(DB_DIR)"

re: down up

.PHONY: all up down logs clean re prepare-dirs
