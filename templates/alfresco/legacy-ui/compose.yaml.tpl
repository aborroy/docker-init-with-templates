{{- if eq .LegacyUI "Yes"}}
services:
  share:
    image: docker.io/alfresco/alfresco-share:${SHARE_TAG}
    environment:
      REPO_HOST: "alfresco"
      REPO_PORT: "8080"
      CSRF_FILTER_REFERER: "http://{{.Server}}:8080/.*"
      CSRF_FILTER_ORIGIN: "http://{{.Server}}:8080"
      JAVA_OPTS: >-
          -XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80
          -Dalfresco.context=alfresco
          -Dalfresco.protocol=http
{{- end}}