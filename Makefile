.PHONY: setup install migrate fresh dev build test clean run up db-setup docker-setup docker-up docker-down docker-build docker-logs docker-ps docker-restart docker-check docker-key-generate help

# Default target: show help
help:
	@echo "Laravel + Docker — http://helloworld.test (stop Apache/AppServ so port 80 is free)"
	@echo ""
	@echo "One command to run everything (Docker + DB + app):"
	@echo "  make up            - configure .env, build app image, start all containers"
	@echo "  make setup         - same as 'up'"
	@echo "  make run           - same as 'up'"
	@echo ""
	@echo "Docker:"
	@echo "  make docker-up     - start containers only"
	@echo "  make docker-down  - stop and remove containers"
	@echo "  make docker-build - rebuild app image and start (after Dockerfile/entrypoint changes)"
	@echo "  make docker-logs  - follow app logs (first start takes 2-5 min; use this to watch)"
	@echo "  make docker-ps    - show container status"
	@echo "  make docker-check - diagnose 502 (status + logs + test health.php)"
	@echo "  make docker-restart - recreate app + nginx"
	@echo ""
	@echo "Local (non-Docker):"
	@echo "  make install      - composer install + npm install"
	@echo "  make db-setup     - configure .env for local MySQL"
	@echo "  make migrate      - run migrations"
	@echo "  make fresh        - migrate:fresh"
	@echo "  make dev          - Laravel + Vite + queue dev servers"
	@echo "  make build        - npm run build"
	@echo "  make test         - run tests"
	@echo "  make clean        - remove node_modules, vendor, public/build"

# ------------------------------------------------------------------------------
# One command: configure .env for Docker, build app image, start all containers.
# First start can take 2-5 min (composer, npm, migrate). Run 'make docker-logs' to watch.
# ------------------------------------------------------------------------------
up: docker-setup
	@echo "[make] Building app image..."
	@docker compose build app
	@echo "[make] Starting db, app, nginx..."
	@docker compose up -d
	@echo ""
	@echo "Containers started. First boot may take 2-5 minutes (composer, npm, migrate)."
	@echo "  Watch progress: make docker-logs"
	@echo "  Then open:      http://helloworld.test"
	@echo "  Stop:           make docker-down"
	@echo "  (Ensure Apache/AppServ is stopped so port 80 is free.)"

# Same as 'up' — one command to run the whole stack
setup: up
run: up
docker-setup:
	@cp -n .env.example .env 2>/dev/null || true
	@sed -i 's/^DB_CONNECTION=.*/DB_CONNECTION=mysql/' .env
	@sed -i 's/^.*DB_HOST=.*/DB_HOST=db/' .env
	@sed -i 's/^.*DB_PORT=.*/DB_PORT=3306/' .env
	@sed -i 's/^.*DB_DATABASE=.*/DB_DATABASE=appdb/' .env
	@sed -i 's/^.*DB_USERNAME=.*/DB_USERNAME=root/' .env
	@sed -i 's/^.*DB_PASSWORD=.*/DB_PASSWORD=12345679/' .env
	@sed -i 's|^.*APP_URL=.*|APP_URL=http://helloworld.test|' .env
	@command -v php >/dev/null 2>&1 && php artisan key:generate --no-interaction 2>/dev/null || true
	@echo ".env configured for Docker (DB_HOST=db)."

# Install PHP and Node dependencies (local, non-Docker)
install:
	composer install
	npm install

# Configure .env for local MySQL (non-Docker, DB_HOST=127.0.0.1)
db-setup:
	@cp -n .env.example .env 2>/dev/null || true
	@sed -i 's/^DB_CONNECTION=.*/DB_CONNECTION=mysql/' .env
	@sed -i 's/^.*DB_HOST=.*/DB_HOST=127.0.0.1/' .env
	@sed -i 's/^.*DB_PORT=.*/DB_PORT=3306/' .env
	@sed -i 's/^.*DB_DATABASE=.*/DB_DATABASE=appdb/' .env
	@sed -i 's/^.*DB_USERNAME=.*/DB_USERNAME=root/' .env
	@sed -i 's/^.*DB_PASSWORD=.*/DB_PASSWORD=123456789/' .env
	@php artisan key:generate --no-interaction 2>/dev/null || true
	@echo "Local MySQL database configured (non-Docker)."

# Generate APP_KEY inside the running Docker app container
docker-key-generate:
	docker compose exec app php artisan key:generate --no-interaction

# Run database migrations
migrate:
	php artisan migrate --force

# Fresh migrations (drop all tables and re-run)
fresh:
	php artisan migrate:fresh --force

# Run dev servers (Laravel + Vite + queue + logs)
dev:
	composer dev

# Build frontend assets for production
build:
	npm run build

# Run tests
test:
	composer test

# Clean generated files
clean:
	rm -rf node_modules vendor public/build

# --- Docker ---
# Start all services (db, app, nginx). App entrypoint runs composer install, npm run build, migrate.
docker-up:
	docker compose up -d

# Stop and remove containers
docker-down:
	docker compose down

# Rebuild app image and start (use after Dockerfile or entrypoint changes)
docker-build:
	docker compose build --no-cache app
	docker compose up -d

# Follow app container logs (useful for debugging 502 or slow first start)
docker-logs:
	docker compose logs -f app

# Show container status
docker-ps:
	docker compose ps

# Diagnose 502: show status, last app logs, and test http://helloworld.test/health.php
docker-check:
	@echo "=== Container status ==="
	@docker compose ps
	@echo ""
	@echo "=== Last 40 lines of app logs ==="
	@docker compose logs app --tail=40
	@echo ""
	@echo "=== Test PHP-FPM: open http://helloworld.test/health.php (should show OK) ==="
	@echo "If health.php also returns 502, nginx cannot reach PHP-FPM (app container may be exited or FPM not listening)."

# Recreate app and nginx (e.g. after nginx.conf or .env change, no full rebuild)
docker-restart:
	docker compose up -d --force-recreate app nginx
