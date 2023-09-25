{{- if eq .Database "mariadb"}}
module github.com/docker/awesome-compose/nginx-golang-mysql/backend

go 1.18

require (
	github.com/go-sql-driver/mysql v1.6.0
	github.com/gorilla/handlers v1.5.1
	github.com/gorilla/mux v1.8.0
)

require github.com/felixge/httpsnoop v1.0.1 // indirect
{{- end}}
{{- if eq .Database "postgres"}}
module github.com/docker/awesome-compose/nginx-golang-postgres/backend

go 1.18

require (
	github.com/gorilla/handlers v1.3.0
	github.com/gorilla/mux v1.6.2
	github.com/lib/pq v1.10.3
)

require github.com/gorilla/context v1.1.1 // indirect
{{- end}}