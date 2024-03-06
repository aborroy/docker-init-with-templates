{{- if eq .LegacyUI "Yes"}}
services:
  share:
    image: quay.io/alfresco/alfresco-share:${SHARE_TAG}
    environment:
      REPO_HOST: "alfresco"
      REPO_PORT: "8080"
      CSRF_FILTER_REFERER: "http://localhost:8080/.*"
      CSRF_FILTER_ORIGIN: "http://localhost:8080"
      JAVA_OPTS: >-
          -XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80
          -Dalfresco.context=alfresco
          -Dalfresco.protocol=http
{{- end}}
    depends_on:
      alfresco:
        condition: service_healthy