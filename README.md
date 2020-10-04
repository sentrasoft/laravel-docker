# Docker for Laravel
Generic Docker Image for Laravel Applications. A pretty simplified Docker Compose workflow that sets up a LEMP network of containers for local Laravel development.

## Usage
To get started, make sure you have [Docker installed](https://docs.docker.com/docker-for-mac/install/) on your system, and then clone this repository.

## Permissions
Execute this command to fix permissions:

```
docker-compose exec app chmod -R 777 storage/
docker-compose exec app chmod -R 777 bootstrap/cache
```