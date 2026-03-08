.PHONY: setup install migrate fresh dev build test clean run db-setup

# First-time setup: install deps, configure local env, run migrations, build assets
setup: install db-setup migrate build
	@echo "Setup complete. Run 'make dev' to start the app."

# Install PHP and Node dependencies
install:
	composer install
	npm install

# Configure .env for local MySQL
db-setup:
	@cp -n .env.example .env 2>/dev/null || true
	@sed -i 's/^DB_CONNECTION=.*/DB_CONNECTION=mysql/' .env
	@sed -i 's/^.*DB_HOST=.*/DB_HOST=127.0.0.1/' .env
	@sed -i 's/^.*DB_PORT=.*/DB_PORT=3306/' .env
	@sed -i 's/^.*DB_DATABASE=.*/DB_DATABASE=appdb/' .env
	@sed -i 's/^.*DB_USERNAME=.*/DB_USERNAME=appuser/' .env
	@sed -i 's/^.*DB_PASSWORD=.*/DB_PASSWORD=apppass/' .env
	@php artisan key:generate --no-interaction 2>/dev/null || true
	@echo "Local MySQL database configured."

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

# Full setup + run dev servers
run: setup dev
