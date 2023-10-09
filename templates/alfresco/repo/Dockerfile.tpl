{{- if or (.Addons) (eq .Database "mariadb")}}
ARG REPO_TAG
FROM docker.io/alfresco/alfresco-content-repository-community:${REPO_TAG}

USER root
ARG TOMCAT_DIR=/usr/local/tomcat

{{- if .Addons}}
RUN mkdir -p $TOMCAT_DIR/amps
{{- end}}

{{- if contains .Addons "Order of the Bee Support Tools"}}
RUN curl -L https://github.com/Alfresco/alfresco-docker-installer/raw/master/generators/app/templates/addons/amps/support-tools-repo-1.2.0.0-amp.amp \
    -o support-tools-repo-1.2.0.0-amp.amp && \
    mv support-tools-repo-1.2.0.0-amp.amp $TOMCAT_DIR/amps
{{- end}}

{{- if contains .Addons "Share Site Creators"}}
RUN curl -L https://github.com/Alfresco/alfresco-docker-installer/raw/master/generators/app/templates/addons/amps/share-site-creators-repo-0.0.8-SNAPSHOT.amp \
    -o share-site-creators-repo-0.0.8-SNAPSHOT.amp && \
    mv share-site-creators-repo-0.0.8-SNAPSHOT.amp $TOMCAT_DIR/amps    
{{- end}}

{{- if .Addons}}
RUN java -jar $TOMCAT_DIR/alfresco-mmt/alfresco-mmt*.jar install \
    $TOMCAT_DIR/amps $TOMCAT_DIR/webapps/alfresco -directory -nobackup -force
{{- end}}

{{- if contains .Addons "OCR Transformer"}}
RUN curl -L https://github.com/Alfresco/alfresco-docker-installer/raw/master/generators/app/templates/addons/alfresco-tengine-ocr/embed-metadata-action-1.0.0.jar \
    -o embed-metadata-action-1.0.0.jar && \
    mv embed-metadata-action-1.0.0.jar $TOMCAT_DIR/webapps/alfresco/WEB-INF/lib/
{{- end}}

{{- if eq .Database "mariadb"}}
RUN set -x \
        && yum install -y wget \
        && yum clean all \
        && wget -P /tmp/ https://repo1.maven.org/maven2/org/mariadb/jdbc/mariadb-java-client/2.7.10/mariadb-java-client-2.7.10.jar \
        && cp /tmp/mariadb-java-client-2.7.10.jar /usr/local/tomcat/lib/ \
        && rm -rf /tmp/mariadb-java-client-2.7.10.jar;
{{- end}}

USER alfresco

{{- end}}