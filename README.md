# Docker for Laravel
Generic Docker Image for Laravel Application. A pretty simplified Docker Compose workflow that sets up a LEMP network of containers for local Laravel development.

## Usage
To get started, make sure you have [Docker installed](https://docs.docker.com/docker-for-mac/install/) on your system, and then clone this repository.

## Install Laravel
Initialize the Laravel project in the `/src` directory. We usually use the [Laravel Installer](https://laravel.com/docs/8.x/installation#installing-laravel) to initialize a Laravel project.

### Via Laravel Installer
```
laravel new src --force
```

### Configure Environment
After initializing the Laravel project, make sure these lines are adjusted in the Laravel .env file.

```
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=trooper
DB_PASSWORD=secret

COMPOSE_PROJECT_NAME=laravel-project-1
```

> Please match the `COMPOSE_PROJECT_NAME` value in [/src/.env](/src/.env) with the [.env](.env) in the root folder.

## Run Laravel
### Using Docker Compose

```
docker-compose up -d
```

> You can open the project url at [http://localhost:8080](http://localhost:8080) or you can customize the port at [docker-compose.yml](docker-compose.yml).

### Migrating
Database host and port in [/src/.env](/src/.env) use `mysql` as host and `port 3306`, this host and port can be accessed by the app container. Therefore, to run `artisan migrate`, please do it via `docker-compose exec`.

```
docker-compose exec app php artisan migrate
```

### Storage Permission
If an error occurs with storage permissions, execute this command to fix permissions:

```
docker-compose exec app chmod -R 777 storage/
docker-compose exec app chmod -R 777 bootstrap/cache
```