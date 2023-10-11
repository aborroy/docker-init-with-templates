services:
  alfresco:
{{- if eq .Database "mariadb"}}
    build:
      context: .
      args:
        ALFRESCO_TAG: ${ALFRESCO_TAG}
{{- else}}        
    image: quay.io/alfresco/alfresco-content-repository:${ALFRESCO_TAG}
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
{{- if or (eq .Search "search-service") (eq .Search "insight-engine")}}
        -Dsolr.host=solr6
        -Dsolr.port=8983
        -Dsolr.secureComms=secret
        -Dsolr.sharedSecret=secret
        -Dindex.subsystem.name=solr6
{{- end}}
{{- if or (eq .Search "search-enterprise-elasticsearch") (eq .Search "search-enterprise-opensearch")}}
        -Delasticsearch.createIndexIfNotExists=true
        -Dindex.subsystem.name=elasticsearch
        -Delasticsearch.host=elasticsearch
        -Delasticsearch.indexName=${ELASTICSEARCH_INDEX_NAME}
{{- end}}             
        -DlocalTransform.core-aio.url=http://transform-core-aio:8090/
{{- if eq .Transform "t-service"}}
        -Dtransform.service.enabled=true
        -Dtransform.service.url=http://transform-router:8095
        -Dsfs.url=http://shared-file-store:8099/
{{- else}}
        -Dtransform.service.enabled=false
{{- end}}
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