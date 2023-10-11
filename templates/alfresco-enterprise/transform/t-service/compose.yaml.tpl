{{- if eq .Transform "t-service"}}
services:
  transform-router:
    image: quay.io/alfresco/alfresco-transform-router:${TRANSFORM_ROUTER_TAG}
    environment:
      JAVA_OPTS: " -XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"
      ACTIVEMQ_URL: "nio://activemq:61616"
  {{- if eq .MessagingCredentials "Yes"}}
      SPRING_ACTIVEMQ_USER: {{.MessagingUser}}
      SPRING_ACTIVEMQ_PASSWORD: {{.MessagingPassword}}
  {{- end}}      
      CORE_AIO_URL: "http://transform-core-aio:8090"
      FILE_STORE_URL: "http://shared-file-store:8099/alfresco/api/-default-/private/sfs/versions/1/file"
    ports:
      - "8095:8095"
    links:
      - activemq

  transform-core-aio:
    image: alfresco/alfresco-transform-core-aio:${TRANSFORM_ENGINE_TAG}
    environment:
      JAVA_OPTS: " -XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"
      ACTIVEMQ_URL: "nio://activemq:61616"
  {{- if eq .MessagingCredentials "Yes"}}
      SPRING_ACTIVEMQ_USER: {{.MessagingUser}}
      SPRING_ACTIVEMQ_PASSWORD: {{.MessagingPassword}}
  {{- end}}      
      FILE_STORE_URL: "http://shared-file-store:8099/alfresco/api/-default-/private/sfs/versions/1/file"
    ports:
      - "8090:8090"
    links:
      - activemq

  shared-file-store:
    image: quay.io/alfresco/alfresco-shared-file-store:${SHARED_FILE_STORE_TAG}
    environment:
      JAVA_OPTS: " -XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"
      scheduler.content.age.millis: 86400000
      scheduler.cleanup.interval: 86400000
    ports:
      - "8099:8099"
    volumes:
      - shared-file-store-volume:/tmp/Alfresco/sfs

volumes:
  shared-file-store-volume:
    driver_opts:
      type: tmpfs
      device: tmpfs      
{{- end}}