ELASTICSEARCH_INDEX_NAME=alfresco

{{- if eq .Version "23.4"}}
ALFRESCO_TAG=23.4.1
SEARCH_TAG=2.0.13
SHARE_TAG=23.4.0
POSTGRES_TAG=15.6
MARIADB_TAG=11.3.2
TRANSFORM_ROUTER_TAG=4.1.5
TRANSFORM_ENGINE_TAG=5.1.5
SHARED_FILE_STORE_TAG=4.1.5
ACTIVEMQ_TAG=5.18-jre17-rockylinux8
ADW_TAG=5.2.0
CONTROL_CENTER_TAG=9.2.0
ACS_NGINX_TAG=3.4.2
SYNC_SERVICE_TAG=5.1.0
ELASTICSEARCH_TAG=7.17.13
KIBANA_TAG=7.17.13
OPENSEARCH_TAG=1.3.19
OPENSEARCH_DASHBOARDS_TAG=1.3.19
LIVE_INDEXING_TAG=4.2.0
{{- end}}
{{- if eq .Version "23.2"}}
ALFRESCO_TAG=23.2.1
SEARCH_TAG=2.0.9.1
SHARE_TAG=23.2.1
POSTGRES_TAG=15.6
MARIADB_TAG=11.3.2
TRANSFORM_ROUTER_TAG=4.1.0
TRANSFORM_ENGINE_TAG=5.1.0
SHARED_FILE_STORE_TAG=4.1.0
ACTIVEMQ_TAG=5.18-jre17-rockylinux8
ADW_TAG=4.4.0
CONTROL_CENTER_TAG=8.4.0
ACS_NGINX_TAG=3.4.2
SYNC_SERVICE_TAG=4.0.1
ELASTICSEARCH_TAG=7.10.1
KIBANA_TAG=7.10.1
OPENSEARCH_TAG=1.3.13
OPENSEARCH_DASHBOARDS_TAG=1.3.13
LIVE_INDEXING_TAG=4.0.0
{{- end}}
{{- if eq .Version "23.1"}}
ALFRESCO_TAG=23.1.0
SEARCH_TAG=2.0.8.2
SHARE_TAG=23.1.0
POSTGRES_TAG=14.4
MARIADB_TAG=11.1.2
TRANSFORM_ROUTER_TAG=4.0.0
TRANSFORM_ENGINE_TAG=5.0.0
SHARED_FILE_STORE_TAG=4.0.0
ACTIVEMQ_TAG=5.17.1-jre11-rockylinux8
ADW_TAG=4.2.0
CONTROL_CENTER_TAG=8.2.0
ACS_NGINX_TAG=3.4.2
SYNC_SERVICE_TAG=4.0.0
ELASTICSEARCH_TAG=7.10.1
KIBANA_TAG=7.10.1
OPENSEARCH_TAG=1.3.13
OPENSEARCH_DASHBOARDS_TAG=1.3.13
LIVE_INDEXING_TAG=4.0.0
{{- end}}
{{- if eq .Version "7.4"}}
ALFRESCO_TAG=7.4.1
SEARCH_TAG=2.0.8
SHARE_TAG=7.4.1
POSTGRES_TAG=14.4
MARIADB_TAG=11.1.2
TRANSFORM_ROUTER_TAG=3.0.0
TRANSFORM_ENGINE_TAG=4.0.0
SHARED_FILE_STORE_TAG=3.0.0
ACTIVEMQ_TAG=5.17.1-jre11-rockylinux8
ADW_TAG=4.1.0
CONTROL_CENTER_TAG=8.1.0
ACS_NGINX_TAG=3.4.2
SYNC_SERVICE_TAG=3.11.0
ELASTICSEARCH_TAG=7.10.1
KIBANA_TAG=7.10.1
OPENSEARCH_TAG=1.3.2
OPENSEARCH_DASHBOARDS_TAG=1.3.2
LIVE_INDEXING_TAG=3.3.0
{{- end}}
{{- if eq .Version "7.3"}}
ALFRESCO_TAG=7.3.1
SEARCH_TAG=2.0.5.1
SHARE_TAG=7.3.1
POSTGRES_TAG=14.4
MARIADB_TAG=11.1.2
TRANSFORM_ROUTER_TAG=1.5.3
TRANSFORM_ENGINE_TAG=2.6.0
SHARED_FILE_STORE_TAG=1.5.3
ACTIVEMQ_TAG=5.17.1-jre11-rockylinux8
ADW_TAG=3.1.0
CONTROL_CENTER_TAG=7.6.0
ACS_NGINX_TAG=3.4.2
SYNC_SERVICE_TAG=3.8.0
ELASTICSEARCH_TAG=7.10.1
KIBANA_TAG=7.10.1
OPENSEARCH_TAG=1.3.2
OPENSEARCH_DASHBOARDS_TAG=1.3.2
LIVE_INDEXING_TAG=3.2.0
{{- end}}