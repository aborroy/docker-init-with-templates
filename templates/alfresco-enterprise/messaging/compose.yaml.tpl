{{- if eq .Messaging "Yes"}}
services:
  activemq:
    image: docker.io/alfresco/alfresco-activemq:${ACTIVEMQ_TAG}
  {{- if eq .MessagingCredentials "Yes"}}    
    environment:
        ACTIVEMQ_ADMIN_LOGIN: "{{.MessagingUser}}"
        ACTIVEMQ_ADMIN_PASSWORD: "{{.MessagingPassword}}"
  {{- end}}
    ports:
      - 61616:61616
{{- end}}