services:
  alfresco:
{{- if or (.Addons) (eq .Database "mariadb")}}
    build:
      context: .
      args:
        REPO_TAG: ${REPO_TAG}
{{- else}}        
    image: docker.io/alfresco/alfresco-content-repository-community:${REPO_TAG}
{{- end}}
    environment:
      JAVA_TOOL_OPTIONS: >-
        -Dencryption.keystore.type=JCEKS
        -Dencryption.cipherAlgorithm=DESede/CBC/PKCS5Padding
        -Dencryption.keyAlgorithm=DESede
        -Dencryption.keystore.location=/usr/local/tomcat/shared/classes/alfresco/extension/keystore/keystore
        -Dmetadata-keystore.password=mp6yc0UD9e
        -Dmetadata-keystore.aliases=metadata
        -Dmetadata-keystore.metadata.password=oKIWzVdEdA
        -Dmetadata-keystore.metadata.algorithm=DESede
      JAVA_OPTS: >-
        -Dcsrf.filter.enabled=false
        -XX:MinRAMPercentage=50
        -XX:MaxRAMPercentage=80
        -Ddb.username=alfresco
        -Ddb.password=alfresco
{{- if eq .Database "postgres"}}  
        -Ddb.driver=org.postgresql.Driver
        -Ddb.url=jdbc:postgresql://postgres:5432/alfresco
{{- end}}
{{- if eq .Database "mariadb"}}
        -Ddb.driver=org.mariadb.jdbc.Driver
        -Ddb.url=jdbc:mariadb://mariadb/alfresco?useUnicode=yes\&characterEncoding=UTF-8
{{- end}}
        -Dsolr.host=solr6
        -Dsolr.port=8983
        -Dsolr.secureComms=secret
        -Dsolr.sharedSecret=secret
        -Dindex.subsystem.name=solr6
        -DlocalTransform.core-aio.url=http://transform-core-aio:8090/
{{- if eq .Messaging "Yes"}}
        -Dmessaging.broker.url="failover:(nio://activemq:61616)?timeout=3000&jms.useCompression=true"
  {{- if eq .MessagingCredentials "Yes"}}
        -Dmessaging.broker.username={{.MessagingUser}}
        -Dmessaging.broker.password={{.MessagingPassword}}
  {{- end}}
{{- else}}
        -Dmessaging.subsystem.autoStart=false
        -Drepo.event2.enabled=false
{{- end}}
{{- if contains .Addons "OCR Transformer"}}
        -DlocalTransform.ocr.url=http://transform-ocr:8090/
{{- end}}
{{- if eq .Volumes "Bind"}}
    volumes:
      - ./data/alf-repo-data:/usr/local/tomcat/alf_data
      - ./logs/alfresco:/usr/local/tomcat/logs    
{{- end}}
{{- if eq .Volumes "Native"}}
    volumes:
      - alf-repo-data:/usr/local/tomcat/alf_data
      - alf-repo-logs:/usr/local/tomcat/logs

volumes:
    alf-repo-data:
    alf-repo-logs:
{{- end}}
