services:
  sync-service:
    image: quay.io/alfresco/service-sync:${SYNC_SERVICE_TAG}
    mem_limit: 1g
    environment:
      JAVA_OPTS: "
        -Dsql.db.driver=org.postgresql.Driver
        -Dsql.db.url=jdbc:postgresql://postgres:5432/alfresco
        -Dsql.db.username=alfresco
        -Dsql.db.password=alfresco
        -Dmessaging.broker.host=activemq
{{- if eq .MessagingCredentials "Yes"}}
        -Dmessaging.broker.username={{.MessagingUser}}
        -Dmessaging.broker.password={{.MessagingPassword}}
{{- end}}
        -Drepo.hostname=alfresco
        -Drepo.port=8080
        -Ddw.server.applicationConnectors[0].type=http
        -XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80
        "
    ports:
      - "9090:9090"