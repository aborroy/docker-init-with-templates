services:
  proxy:
    image: docker.io/alfresco/alfresco-acs-nginx:${ACS_NGINX_TAG}
    mem_limit: 128m
    environment:
      DISABLE_PROMETHEUS: "true"
{{- if eq .Sync "No"}}      
      DISABLE_SYNCSERVICE: "true"
{{- end}}      
{{- if eq .LegacyUI "No"}}
      DISABLE_SHARE: "true"
{{- end}}
      DISABLE_ADW: "false"
      DISABLE_CONTROL_CENTER: "false"
      ENABLE_CONTENT_APP: "false"
    depends_on:
      - alfresco
    ports:
      - "8080:8080"
    links:
      - alfresco