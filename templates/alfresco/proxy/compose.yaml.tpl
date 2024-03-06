services:
  proxy:
    image: docker.io/alfresco/alfresco-acs-nginx:${PROXY_TAG}
    mem_limit: 128m
    environment:
      DISABLE_PROMETHEUS: "true"
      DISABLE_SYNCSERVICE: "true"
      DISABLE_ADW: "true"
{{- if eq .LegacyUI "No"}}      
      DISABLE_SHARE: "true"
{{- end}}      
      DISABLE_CONTROL_CENTER: "true"
      ENABLE_CONTENT_APP: "true"
    depends_on:
      - alfresco
      - content-app
{{- if eq .LegacyUI "Yes"}}
      - share
{{- end}}      
    ports:
      - "8080:8080"
    links:
      - content-app
      - alfresco
{{- if eq .LegacyUI "Yes"}}
      - share
{{- end}}      
