## 1. Provided Services
-   **Nginx**: A high-performance web server that serves as a reverse proxy for the WordPress application. It handles incoming HTTP/HTTPS requests and forwards them to the appropriate backend service.
-   **WordPress**: Popular website builder that runs on PHP-FPM.
-   **MariaDB**: A database used for store wordpress data.

---

## 2. Managing the Project

### Start the project
```bash
make
```

### Stop the project
```bash
make down
```

### Full reset
```bash
make fclean
```

---

## 3. Accessing the Website
-   **Public Website**: https://login.42.fr
-   **Administration Panel**: https://login.42.fr/wp-admin

> **Note**: Since the project uses a custom domain, ensure your `/etc/hosts` file contains the following entry:
> `127.0.0.1 login.42.fr`
> **Note**: Ignore SSL warnings when accessing the site, as it uses a self-signed certificate for HTTPS.
> **Note**: Replace `login` with your actual 42 login in the URLs above. (e.g. `https://bkiskac.42.fr`)
> **Note**: Please ensure that container is running before trying to access the website.

---

## 4. Credentials and Configuration

All credentials and environment configurations are managed via the `.env` file located in the `srcs/` directory.

### Key Configuration Variables:
-   **WordPress Admin**: `WP_ADMIN_USER` and `WP_ADMIN_PASSWORD`
-   **WordPress User**: `WP_USER` and `WP_USER_PASSWORD`
-   **Database**: `SQL_USER`, `SQL_PASSWORD`, and `SQL_ROOT_PASSWORD`
---

## 5. Checking Service Health

To verify that all services are running correctly, you can use the following methods:

### Check Container Status
```bash
docker ps
```
You should see 3 containers (`nginx`, `wordpress`, `mariadb`) with a status of **Up**.

### Check Logs
If you encounter issues, check the output of a specific container:
```bash
docker logs nginx
docker logs wordpress
docker logs mariadb
```
