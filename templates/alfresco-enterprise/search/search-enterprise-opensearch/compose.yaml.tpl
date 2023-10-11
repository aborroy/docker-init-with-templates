{{- if eq .Search "search-enterprise-opensearch"}}
services:
  elasticsearch:
    image: opensearchproject/opensearch:${OPENSEARCH_TAG}
    mem_limit: 1700m
    container_name: elasticsearch
    environment:
      - discovery.type=single-node
      - cluster.name=elasticsearch
      - node.name=elasticsearch
      - bootstrap.memory_lock=true
      - DISABLE_INSTALL_DEMO_CONFIG=true
      - DISABLE_SECURITY_PLUGIN=true
    ulimits:
      memlock:
        soft: -1
        hard: -1
      nofile:
        soft: 65536
        hard: 65536
    cap_add:
      - IPC_LOCK
    ports:
      - 9200:9200
      - 9300:9300

  kibana:
    image: opensearchproject/opensearch-dashboards:${OPENSEARCH_DASHBOARDS_TAG}
    mem_limit: 256m
    environment:
      - 'OPENSEARCH_HOSTS=["http://elasticsearch:9200"]'
      - DISABLE_SECURITY_DASHBOARDS_PLUGIN=true
    ports:
      - 5601:5601
    depends_on:
      - elasticsearch


  live-indexing:
    image: quay.io/alfresco/alfresco-elasticsearch-live-indexing:${LIVE_INDEXING_TAG}
    depends_on:
      - elasticsearch
      - alfresco
    environment:
      SPRING_ELASTICSEARCH_REST_URIS: http://elasticsearch:9200
      SPRING_ACTIVEMQ_BROKERURL: nio://activemq:61616
  {{- if eq .MessagingCredentials "Yes"}}
      SPRING_ACTIVEMQ_USER: {{.MessagingUser}}
      SPRING_ACTIVEMQ_PASSWORD: {{.MessagingPassword}}
  {{- end}}
      ALFRESCO_ACCEPTEDCONTENTMEDIATYPESCACHE_BASEURL: http://transform-core-aio:8090/transform/config
      ALFRESCO_SHAREDFILESTORE_BASEURL: http://shared-file-store:8099/alfresco/api/-default-/private/sfs/versions/1/file/
{{- end}}