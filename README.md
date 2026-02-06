# Inception

*This project has been created as part of the 42 curriculum by bkiskac.*

## Description
This project aims to teach about system administration by using Docker. Instead of managing a full virtual machines, this project focuses on Dockerizing several services such as NGINX, Wordpress and Mariadb into separate docker containers that communicate and works in sync within a custom Docker network with help of Docker Compose.

## Instructions

### Prerequisites
- **OS:** Linux (Ubuntu preferred)
- **Tools:** Docker Engine, Docker Compose, Make, Git

### Installation & Execution
1.  **Clone the repository:**
    ```bash
    git clone <repo url> Inception
    cd Inception
    ```

2.  **Configure Host:**
    Map the domain name to your local IP address in the `/etc/hosts` file. (login in domain must be your 42 login)
    ```bash
    sudo nano /etc/hosts
    # Add the following line:
    127.0.0.1   login.42.fr
    ```

3.  **Build and Run:**
    Launch the setup using the Makefile located at the root. This command will create the necessary data directories and build the docker images.
    ```bash
    make
    ```

4.  **Access:**
    - **WordPress Website:** Open `https://login.42.fr` in your browser. (Replace `login` with your actual 42 login. Ignore SSL warnings for self-signed certificates.)

### Management
- **Stop containers:** `make down`
- **Clean up (Stop + Remove containers, networks, images & volumes):** `make fclean`
- **Rebuild:** `make re`

## Project Description & Technical Choices

1.  **NGINX:** The entry point. It handles HTTPS requests and behaves as a reverse proxy to forward requests to the WordPress container. Also used for caching static content and load balancing.
2.  **WordPress:** Runs the PHP-FPM server to process dynamic content and serves the WordPress application.
3.  **MariaDB:** The database server storing WordPress data.

### Comparison of Concepts

#### Virtual Machines vs. Docker
- **Virtual Machines:** Virtualize the entire hardware layer. Each VM runs a full Operating System and have their own kernel. This makes them heavier, slower to start, and less portable compared to containers.
- **Docker:** Virtualizes the Operating System layer. Containers share the host's kernel so thanks to this  they are lightweight, start faster, and are more portable than VMs.

#### Secrets vs. Environment Variables
- **Environment Variables:** Stored in `.env` files or passed via command line. They are easy to use but can be insecure if visible in process listings or logs.
- **Docker Secrets:** A secure way to store sensitive data (passwords, keys). They are encrypted at rest and only mounted into the containers that specifically need them.

#### Docker Network vs. Host Network
- **Host Network:** The container shares the host’s networking namespace. It uses the host's IP and ports directly, offering no isolation.
- **Docker Network (Bridge):** Creates an isolated software bridge. Containers on the same bridge can communicate using their container names (DNS resolution) without exposing ports to the outside world, unless explicitly mapped. This project uses a custom bridge network to secure traffic between WordPress and MariaDB.

#### Docker Volumes vs. Bind Mounts
- **Bind Mounts:** Map a specific file or directory on the host machine to the container. They rely on the host's specific file system structure.
- **Docker Volumes:** Managed by Docker (stored in `/var/lib/docker/volumes/`). They are more easy to back up, migrate, and work across different host systems. This project uses Docker Volumes for persisting database data and WordPress files. (We use named volumes for the database and website files to ensure data persists even if containers are restarted.)

## Resources
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [NGINX Documentation](https://nginx.org/en/docs/)
- [WordPress Docker Official Image](https://hub.docker.com/_/wordpress)
- [MariaDB Docker Official Image](https://hub.docker.com/_/mariadb)

### AI Usage
*AI tools were used to generate initial explanations and find useful documentation. Also they are used in testing in debugging*
