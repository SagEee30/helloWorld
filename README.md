# Hello World Application

This repository contains a Laravel application with a fully configured Docker environment (MySQL, Nginx, PHP-FPM). 
Follow the instructions below to get the project up and running on your local machine.

## Prerequisites

Before you begin, ensure you have the following installed:
- [Git](https://git-scm.com/)
- [Docker](https://www.docker.com/) and Docker Compose
- *Optional: PHP 8.3+, Composer, and Node.js (if running locally without Docker)*

---

## 🚀 Quick Start (Docker)

The easiest way to run the application is using the provided Docker environment. We have prepared a `Makefile` to simplify the process.

### 1. Clone the repository
```bash
git clone <repository-url>
cd helloWorld
```

### 2. Configure your Hosts file
The application is configured to run at `http://helloworld.test`. You need to map this domain to your localhost.
Add the following line to your system's hosts file:
- **Windows**: `C:\Windows\System32\drivers\etc\hosts`
- **Mac/Linux**: `/etc/hosts`

```text
127.0.0.1   helloworld.test
```

### 3. Start the Application
Make sure you don't have Apache, Nginx, or AppServ running locally on port 80, as Docker needs this port.
Run the following command:

```bash
make up
```

**What `make up` does:**
- Copies `.env.example` to `.env` and configures it automatically for Docker (DB host, passwords, etc.).
- Generates the Laravel App Key.
- Builds the Docker containers (Nginx, App, DB).
- Automatically installs PHP dependencies (`composer install`), Node dependencies (`npm install`), builds front-end assets (`npm run build`), and runs database migrations on the first container boot.

*Note: The first boot may take 2-5 minutes to install all dependencies. You can watch the progress by running `make docker-logs` in another terminal.*

### 4. Access the Application
Open your browser and navigate to: [http://helloworld.test](http://helloworld.test)

---

## 🛠️ Useful Docker Commands

Our `Makefile` includes several helper commands for managing your Docker environment:

- `make docker-up` — Start existing containers.
- `make docker-down` — Stop and remove containers.
- `make docker-build` — Rebuild the app image and start it (use if you modify `Dockerfile` or entrypoint).
- `make docker-logs` — Follow the app container logs.
- `make docker-ps` — Show container status.
- `make docker-restart` — Recreate app and Nginx containers.
- `make docker-check` — Diagnose 502 Bad Gateway errors (shows status, logs, and tests connectivity).

---

## 💻 Local Setup (Non-Docker)

If you prefer to run the application using your own local PHP, MySQL, and Nginx/Apache servers (like XAMPP or Valet), you can do so:

1. **Install Dependencies:**
   ```bash
   make install
   ```

2. **Database Setup:**
   Ensure you have a local MySQL server running. Configure your `.env` for local development by running:
   ```bash
   make db-setup
   ```
   *(This configures `.env` with `DB_HOST=127.0.0.1` and standard local credentials).*

3. **Run Migrations:**
   ```bash
   make migrate
   ```

4. **Start Development Servers:**
   This command starts the Laravel artisan server, Vite for frontend assets, and other background workers.
   ```bash
   make dev
   ```

5. Access the app locally typically via `http://localhost:8000` or depending on your Valet setup.

---

## Troubleshooting

- **502 Bad Gateway (Docker)**: This usually means PHP-FPM hasn't finished starting up (dependencies are still installing). Run `make docker-logs` to monitor the startup process. Give it a few minutes on the first run.
- **Database Connection Refused**: If running via Docker, make sure your `.env` has `DB_HOST=db`. If running locally, ensure `DB_HOST=127.0.0.1` and that your local MySQL is running.
