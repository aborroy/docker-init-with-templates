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
{{- end}}
    healthcheck:
      test: [ "CMD", "healthcheck.sh", "--connect", "--innodb_initialized" ]
      interval: 10s
      timeout: 5s
      retries: 5