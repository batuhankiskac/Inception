## 1. Environment Setup

### Prerequisites
Before starting, ensure your development environment has the following installed:
-   **Docker**
-   **Docker Compose** (v2.0+)
-   **GNU Make**
-   **OpenSSL**

### Configuration Files
-   **`srcs/docker-compose.yml`**: The main orchestration file for docker containers.
-   **`srcs/.env`**: Contains environment variables for database credentials and domain configuration.
-   **`srcs/requirements/`**: Contains the Dockerfiles and configuration files for each service.

### Secrets Management
Secrets are stored in the `srcs/.env` file. Do **not** commit this file to public repositories.
Example `.env` content:
```dotenv
SQL_DATABASE=
SQL_USER=
SQL_PASSWORD=
SQL_ROOT_PASSWORD=
DOMAIN_NAME=
WP_TITLE=
WP_ADMIN_USER=
WP_ADMIN_PASSWORD=
WP_ADMIN_EMAIL=
WP_USER=
WP_USER_EMAIL=
WP_USER_PASSWORD=

```

---

## 2. Build and Launch
### Initial Build
```bash
make
```
This triggers `docker compose up -d --build` after ensuring the data directories exist.

### Rebuilding
```bash
make re
```
This runs `fclean` and then `all`.

---

## 3. Management Commands

### Container Operations
-   **List containers**: `docker compose -f srcs/docker-compose.yml ps`
-   **Stop containers**: `make down`
-   **Restart a specific service**: `docker compose -f srcs/docker-compose.yml restart <service_name>`
-   **View logs**: `docker compose -f srcs/docker-compose.yml logs <service_name>`

### Volume Operations
-   **List volumes**: `docker volume ls`
-   **Inspect volume**: `docker volume inspect <volume_name>`

---

## 4. Data Storage and Persistence
### Storage Locations
-   **MariaDB Data**: `/home/login/data/mariadb`
-   **WordPress Files**: `/home/login/data/wordpress`

### Persistence Logic
When make down is executed, the containers are stopped but the volumes remain existing, so the data is preserved even if the containers are removed. When make fclean is executed, the volumes are removed, so all data will be lost.

---
