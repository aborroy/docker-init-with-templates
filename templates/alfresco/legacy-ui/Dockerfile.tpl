{{- if and (eq .LegacyUI "Yes") (.Addons)}}
ARG SHARE_TAG
FROM docker.io/alfresco/alfresco-share:${SHARE_TAG}

ARG TOMCAT_DIR=/usr/local/tomcat

{{- if .Addons}}
RUN mkdir -p $TOMCAT_DIR/amps
{{- end}}

{{- if contains .Addons "Order of the Bee Support Tools"}}
RUN curl -L https://github.com/Alfresco/alfresco-docker-installer/raw/master/generators/app/templates/addons/amps_share/support-tools-share-1.2.0.0-amp.amp \
    -o support-tools-share-1.2.0.0-amp.amp && \
    mv support-tools-share-1.2.0.0-amp.amp $TOMCAT_DIR/amps
{{- end}}

{{- if contains .Addons "Share Site Creators"}}
RUN curl -L https://github.com/Alfresco/alfresco-docker-installer/raw/master/generators/app/templates/addons/amps_share/share-site-creators-share-0.0.8-SNAPSHOT.amp \
    -o share-site-creators-share-0.0.8-SNAPSHOT.amp && \
    mv share-site-creators-share-0.0.8-SNAPSHOT.amp $TOMCAT_DIR/amps    
{{- end}}

{{- if .Addons}}
RUN java -jar $TOMCAT_DIR/alfresco-mmt/alfresco-mmt*.jar install \
    $TOMCAT_DIR/amps $TOMCAT_DIR/webapps/share -directory -nobackup -force
{{- end}}

{{- end}}