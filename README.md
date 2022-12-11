
# Multi-App PHP / Laravel Development Environment using Docker Compose
#### Featuring Caddy, MySQL, PHP 8.1 FPM, Redis, PhpMyAdmin, & Mailhog


## Setup

1. To Start, Create a directory tree as such:

 - Projects
	 - Docker
	 - Repos
	 - Services
		 - caddy
		 - mysql

2. Clone your app into the a subfolder under `Repos`

3. Copy `docker-compose.yaml` & `Caddyfile` into the `Projects` folder

4. Copy `php-fpm-runtime.Dockerfile` into `Projects\Docker` folder

5. From the `Projects` folder run `docker compose up -d`

6. Adjust docker-compose.yaml for your projects. Duplicate the example app for PHP based apps

7. Adjust Caddyfile for your Apps and Services. See https://caddyserver.com/docs/caddyfile for more help

8. From the `Projects` folder run `docker compose up -d && docker compose restart caddy` to apply new settings.


## Services Links

[https://app.localhost/](https://app.localhost/) is where you will find you PHP App

[https://phpmyadmin.localhost/](https://phpmyadmin.localhost/) is your PhpMyAdmin UI

[https://mailhog.localhost/](https://mailhog.localhost/) is your mailhog UI

## Thank You!

Feel Free to Fork & Enjoy!
