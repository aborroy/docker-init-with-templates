{{- if eq .Messaging "Yes"}}
services:
  activemq:
    image: docker.io/alfresco/alfresco-activemq:${ACTIVEMQ_TAG}
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