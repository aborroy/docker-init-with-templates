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
  {{- if eq .Volumes "Bind"}}
    volumes:
      - ./data/activemq-data:/opt/activemq/data
  {{- end}}
  {{- if eq .Volumes "Native"}}
    volumes:
      - activemq-data:/opt/activemq/data

volumes:
    activemq-data:
  {{- end}}    
{{- end}}