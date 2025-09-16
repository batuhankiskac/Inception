all: up

up:
	@echo "Starting Inception project..."
	@mkdir -p /home/$(USER)/data/wordpress_files
	@mkdir -p /home/$(USER)/data/mariadb_data
	docker compose -f ./srcs/docker-compose.yml up --build -d

down:
	@echo "Stopping Inception project..."
	docker compose -f ./srcs/docker-compose.yml down

logs:
	docker compose -f ./srcs/docker-compose.yml logs -f

clean:
	@echo "Cleaning all Inception data..."
	docker compose -f ./srcs/docker-compose.yml down --volumes --rmi all
	docker system prune -af
	@rm -rf /home/$(USER)/data/wordpress_files
	@rm -rf /home/$(USER)/data/mariadb_data

.PHONY: all up down logs clean
