{{- if eq .Database "mariadb"}}
ARG ALFRESCO_TAG
FROM quay.io/alfresco/alfresco-content-repository:${ALFRESCO_TAG}

USER root
ARG TOMCAT_DIR=/usr/local/tomcat

RUN set -x \
        && yum install -y wget \
        && yum clean all \
        && wget -P /tmp/ https://repo1.maven.org/maven2/org/mariadb/jdbc/mariadb-java-client/2.7.10/mariadb-java-client-2.7.10.jar \
        && cp /tmp/mariadb-java-client-2.7.10.jar /usr/local/tomcat/lib/ \
        && rm -rf /tmp/mariadb-java-client-2.7.10.jar;

USER alfresco

{{- end}}