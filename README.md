# Hello World Application

This repository contains a Laravel application with a fully optimized, "one-command" Docker environment. It is designed to work seamlessly from a clean clone, handling all system dependencies, database setup, and frontend builds automatically.

---

## 🚀 One-Command Quick Start

The easiest way to run the application is using the provided Docker environment via the `Makefile`.

### 1. Prerequisites
Ensure you have **Docker** and **Git** installed. If you are on Windows, we recommend using **WSL2**.

### 2. Configure Host Domain
Map the local domain to your machine by adding the following line to your system's hosts file:
- **Windows**: `C:\Windows\System32\drivers\etc\hosts`
- **Linux/Mac**: `/etc/hosts`

```text
127.0.0.1   helloworld.test
```

### 3. Launch the App
Clone the repo and run the deployment command:

```bash
git clone <repository-url>
cd helloWorld
make up
```

**What `make up` does for you:**
- **Automatic Configuration**: Creates the `.env` file from `.env.example` and optimizes it for Docker.
- **Dependency Management**: Automatically runs `composer install` and `npm install` inside the container.
- **Frontend Build**: Compiles assets with **Vite** (production mode).
- **Database Provisioning**: Reconciles migrations and ensures the `appdb` is ready.
- **Modern UI**: Serves a sleek, dark-themed experience with **Glassmorphism** and **Micro-animations**.

---

## 🛠️ Management Commands

We've simplified management with several `make` targets:

| Command | Action |
| :--- | :--- |
| `make up` | Full deployment (Config + Build + Up). |
| `make docker-down` | Stop and remove all containers. |
| `make docker-logs` | Stream logs from the app container (useful for monitoring boot). |
| `make docker-check` | Run a diagnostic sweep (Ports, Logs, Connectivity). |
| `make docker-restart`| Quick refresh of the Nginx and App services. |

---

## 💡 Troubleshooting

### 502 Bad Gateway
This usually occurs during the first boot while dependencies are still installing.
- **Check Progress**: Run `make docker-logs`.
- **Port Conflict**: Ensure no local **Apache** or **Nginx** is running on your host machine. Run `make docker-check` to confirm port 80 is free for Docker.
- **Manual Migration Fix**: If the app loads but shows "Table not found", run:
  ```bash
  docker exec helloworld-app-1 php artisan migrate:fresh --force
  ```

### Git Ownership Error
If you see "detected dubious ownership", don't worry—the `docker-entrypoint.sh` now automatically fixes this by adding `/var/www` to the safe directory list.


## ✨ Features
- **One-Command Setup**: Zero manual configuration required.
- **Layer Caching**: Optimized Docker builds for speed.
- **Glassmorphism UI**: Beautiful, modern dashboard with interactive elements.
- **Inertia.js + Vue 3**: A powerful, modern SPA-like development experience.****
