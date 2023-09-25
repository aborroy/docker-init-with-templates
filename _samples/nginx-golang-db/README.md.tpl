## Compose sample application

### Use with Docker Development Environments

You can open this sample in the Dev Environments feature of Docker Desktop version 4.12 or later.

[Open in Docker Dev Environments <img src="../open_in_new.svg" alt="Open in Docker Dev Environments" align="top"/>](https://open.docker.com/dashboard/dev-envs?url=https://github.com/docker/awesome-compose/tree/master/nginx-golang-mysql)

### Go server with an Nginx proxy and a {{.Database}} database

Project structure:
```
.
├── backend
│   ├── Dockerfile
│   ├── go.mod
│   ├── go.sum
│   └── main.go
├── db
│   └── password.txt
├── proxy
│   └── nginx.conf
├── compose.yaml
└── README.md
```

[_compose.yaml_](compose.yaml)
```yaml
services:
  backend:
    build:
      context: backend
      target: builder
    ...
  db:
{{- if eq .Database "mariadb"}}
    image: mariadb:10-focal
{{- end}}    
{{- if eq .Database "postgres"}}
    image: postgres
{{- end}}
    ...
  proxy:
    image: nginx
    volumes:
      - type: bind
        source: ./proxy/nginx.conf
        target: /etc/nginx/conf.d/default.conf
        read_only: true
    ports:
    - 80:80
    ...
```
The compose file defines an application with three services `proxy`, `backend` and `db`.
When deploying the application, docker compose maps port 80 of the proxy service container to port 80 of the host as specified in the file.
Make sure port 80 on the host is not already being in use.

{{- if eq .Database "mariadb"}}
> ℹ️ **_INFO_**  
> For compatibility purpose between `AMD64` and `ARM64` architecture, we use a MariaDB as database instead of MySQL.  
> You still can use the MySQL image by uncommenting the following line in the Compose file   
> `#image: mysql:8`
{{- end}}

## Deploy with docker compose

```shell
$ docker compose up -d
Creating network "nginx-golang-{{.Database}}_default" with the default driver
Building backend
Step 1/8 : FROM golang:1.13-alpine AS build
1.13-alpine: Pulling from library/golang
...
Successfully built 5f7c899f9b49
Successfully tagged nginx-golang-{{.Database}}_proxy:latest
WARNING: Image for service proxy was built because it did not already exist. To rebuild this image you must use `docker compose build` or `docker compose up --build`.
Creating nginx-golang-{{.Database}}_db_1 ... done
Creating nginx-golang-{{.Database}}_backend_1 ... done
Creating nginx-golang-{{.Database}}_proxy_1   ... done
```

## Expected result

Listing containers must show three containers running and the port mapping as below:
```shell
$ docker compose ps
NAME                           COMMAND                  SERVICE             STATUS              PORTS
nginx-golang-{{.Database}}-backend-1   "/code/bin/backend"      backend             running
{{- if eq .Database "mariadb"}}
nginx-golang-{{.Database}}-db-1        "docker-entrypoint.s…"   db                  running (healthy)   3306/tcp
{{- end}}
{{- if eq .Database "postgres"}}
nginx-golang-{{.Database}}-db-1        "docker-entrypoint.s…"   db                  running (healthy)   5432/tcp
{{- end}}
nginx-golang-{{.Database}}-proxy-1     "/docker-entrypoint.…"   proxy               running             0.0.0.0:80->80/tcp
l_db_1
```

After the application starts, navigate to `http://localhost:80` in your web browser or run:
```shell
$ curl localhost:80
["Blog post #0","Blog post #1","Blog post #2","Blog post #3","Blog post #4"]
```

Stop and remove the containers
```shell
$ docker compose down
```
