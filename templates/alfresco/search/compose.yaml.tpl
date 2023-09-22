services:
  solr6:
    image: docker.io/alfresco/alfresco-search-services:${SEARCH_TAG}
    environment:
      SOLR_ALFRESCO_HOST: "alfresco"
      SOLR_ALFRESCO_PORT: "8080"
      SOLR_SOLR_HOST: "solr6"
      SOLR_SOLR_PORT: "8983"
      SOLR_CREATE_ALFRESCO_DEFAULTS: "alfresco"
      ALFRESCO_SECURE_COMMS: "secret"
      JAVA_TOOL_OPTIONS: >-
        -Dalfresco.secureComms.secret=secret
      SOLR_OPTS: >-
        -XX:-UseLargePages
        -XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80
{{- if eq .Volumes "Bind"}}
    volumes:
      - ./data/solr-data:/opt/alfresco-search-services/data
{{- end}}
{{- if eq .Volumes "Native"}}
    volumes:
      - solr-data:/opt/alfresco-search-services/data

volumes:
    solr-data:
{{- end}}        