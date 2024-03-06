{{- if eq .Search "insight-engine"}}
services:
  solr6:
    image: quay.io/alfresco/insight-engine:${SEARCH_TAG}
    environment:
      SOLR_ALFRESCO_HOST: "alfresco"
      SOLR_ALFRESCO_PORT: "8080"
      SOLR_SOLR_HOST: "solr6"
      SOLR_SOLR_PORT: "8983"
      SOLR_CREATE_ALFRESCO_DEFAULTS: "alfresco,archive"
      ALFRESCO_SECURE_COMMS: "secret"
      JAVA_TOOL_OPTIONS: >-
        -Dalfresco.secureComms.secret=secret
      SOLR_OPTS: >-
        -XX:-UseLargePages
        -XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80
{{- end}}
    depends_on:
      alfresco:
        condition: service_healthy