{{- if eq .Database "postgres"}}
services:
  postgres:
    image: docker.io/postgres:${POSTGRES_TAG}
    mem_limit: 512m
    environment:
      - POSTGRES_PASSWORD=alfresco
      - POSTGRES_USER=alfresco
      - POSTGRES_DB=alfresco
    command: postgres -c max_connections=300 -c log_min_messages=LOG
  {{- if eq .Volumes "Bind"}}
    volumes:
      - ./data/postgres-data:/var/lib/postgresql/data
      - ./logs/postgres:/var/log/postgresql    
  {{- end}}
  {{- if eq .Volumes "Native"}}
    volumes:
      - postgres-data:/var/lib/postgresql/data
      - postgres-logs:/var/log/postgresql

volumes:
    postgres-data:
    postgres-logs:
  {{- end}}    
{{- end}}
{{- if eq .Database "mariadb"}}
services:
  mariadb:
    image: docker.io/mariadb:${MARIADB_TAG}
    environment:
        - MYSQL_ROOT_PASSWORD=alfresco
        - MYSQL_DATABASE=alfresco
        - MYSQL_USER=alfresco
        - MYSQL_PASSWORD=alfresco
    command: >-
        --character-set-server=utf8
        --collation-server=utf8_bin
        --lower_case_table_names=1
        --max_connections=200
        --innodb-flush-method=O_DIRECT
        --wait_timeout=28800
  {{- if eq .Volumes "Bind"}}
    volumes:
      - ./data/mariadb_data:/var/lib/mysql
      - ./logs/mariadb:/var/log/mysql   
  {{- end}}
  {{- if eq .Volumes "Native"}}
    volumes:
      - mariadb-data:/var/lib/mysql
      - mariadb-logs:/var/log/mysql

volumes:
    mariadb-data:
    mariadb-logs:
  {{- end}}
{{- end}}        