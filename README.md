
# Multi-App PHP / Laravel Development Environment using Docker Compose
#### Featuring Caddy, MySQL, PHP 8.1 FPM, Redis, PhpMyAdmin, & Mailhog


## Setup

1. Clone: `git clone https://github.com/clandestine8/DockerProjects.git Projects && cd Projects`

2. Clone your app(s) into the a subfolder under `Repos`

3. From the `Projects` folder run `docker compose up -d`

4. Adjust `docker-compose.yaml` for your projects. Duplicate the example app for PHP based apps

5. Adjust `Caddyfile` for your Apps and Services. See https://caddyserver.com/docs/caddyfile for more help

6. From the `Projects` folder run `docker compose up -d && docker compose restart caddy` to apply new settings.


## Services Links

[https://--app-url--.localhost/](https://app.localhost/) is where you will find you PHP App

[https://phpmyadmin.localhost/](https://phpmyadmin.localhost/) is your PhpMyAdmin UI

[https://mailhog.localhost/](https://mailhog.localhost/) is your mailhog UI

## Thank You!

Feel Free to Fork & Enjoy!
