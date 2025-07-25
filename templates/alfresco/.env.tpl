SERVER_NAME={{.Server}}

{{- if eq .Version "25.2"}}
POSTGRES_TAG=15.6
MARIADB_TAG=11.3.2
ACTIVEMQ_TAG=5.18-jre17-rockylinux8
PROXY_TAG=3.4.2
REPO_TAG=25.2.0
SEARCH_TAG=2.0.16
TRANSFORM_TAG=5.2.0
UI_TAG=7.0.0
SHARE_TAG=25.2.0
{{- end}}
{{- if eq .Version "25.1"}}
POSTGRES_TAG=15.6
MARIADB_TAG=11.3.2
ACTIVEMQ_TAG=5.18-jre17-rockylinux8
PROXY_TAG=3.4.2
REPO_TAG=25.1.0
SEARCH_TAG=2.0.15
TRANSFORM_TAG=5.1.7
UI_TAG=6.0.0
SHARE_TAG=25.1.0
{{- end}}
{{- if eq .Version "23.4"}}
POSTGRES_TAG=15.6
MARIADB_TAG=11.3.2
ACTIVEMQ_TAG=5.18-jre17-rockylinux8
PROXY_TAG=3.4.2
REPO_TAG=23.4.0
SEARCH_TAG=2.0.13
TRANSFORM_TAG=5.1.5
UI_TAG=5.2.0
SHARE_TAG=23.4.1
{{- end}}
{{- if eq .Version "23.2"}}
POSTGRES_TAG=15.6
MARIADB_TAG=11.3.2
ACTIVEMQ_TAG=5.18-jre17-rockylinux8
PROXY_TAG=3.4.2
REPO_TAG=23.2.1
SEARCH_TAG=2.0.9.1
TRANSFORM_TAG=5.1.0
UI_TAG=4.4.0
SHARE_TAG=23.2.1
{{- end}}
{{- if eq .Version "23.1"}}
POSTGRES_TAG=14.4
MARIADB_TAG=11.1.2
ACTIVEMQ_TAG=5.17.1-jre11-rockylinux8
PROXY_TAG=3.4.2
REPO_TAG=23.1.0
SEARCH_TAG=2.0.8.2
TRANSFORM_TAG=5.0.0
UI_TAG=4.3.0
SHARE_TAG=23.1.0
{{- end}}
{{- if eq .Version "7.4"}}
POSTGRES_TAG=14.4
MARIADB_TAG=11.1.2
ACTIVEMQ_TAG=5.17.1-jre11-rockylinux8
PROXY_TAG=3.4.2
REPO_TAG=7.4.1
SEARCH_TAG=2.0.8
TRANSFORM_TAG=4.0.0
UI_TAG=4.1.0
SHARE_TAG=7.4.1
{{- end}}
{{- if eq .Version "7.3"}}
POSTGRES_TAG=14.4
MARIADB_TAG=11.1.2
ACTIVEMQ_TAG=5.17.1-jre11-rockylinux8
PROXY_TAG=3.4.2
REPO_TAG=7.3.1
SEARCH_TAG=2.0.6
TRANSFORM_TAG=3.0.0
UI_TAG=3.1.0
SHARE_TAG=7.3.1
{{- end}}