{{- if eq .Database "mariadb"}}
ARG REPO_TAG
FROM docker.io/alfresco/alfresco-content-repository-community:${REPO_TAG}

USER root

RUN set -x \
        && yum install -y wget \
        && yum clean all \
        && wget -P /tmp/ https://repo1.maven.org/maven2/org/mariadb/jdbc/mariadb-java-client/3.2.0/mariadb-java-client-3.2.0.jar \
        && cp /tmp/mariadb-java-client-3.2.0.jar /usr/local/tomcat/lib/ \
        && rm -rf /tmp/mariadb-java-client-3.2.0.jar;

USER alfresco
{{- end}}