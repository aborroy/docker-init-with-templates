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
{{- end}}