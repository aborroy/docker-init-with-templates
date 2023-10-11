{{- if eq .Transform "t-engine"}}
services:
  transform-core-aio:
    image: quay.io/alfresco/alfresco-transform-core-aio:${TRANSFORM_ENGINE_TAG}
    environment:
      JAVA_OPTS: >-
        -XX:MinRAMPercentage=50
        -XX:MaxRAMPercentage=80
        -Dserver.tomcat.threads.max=12
        -Dserver.tomcat.threads.min=4
        -Dlogging.level.org.alfresco.transform.common.TransformerDebug=ERROR
        -Dlogging.level.org.alfresco.transform=ERROR
{{- end}}