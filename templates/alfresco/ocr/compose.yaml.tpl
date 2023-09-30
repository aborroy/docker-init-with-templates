{{- if contains .Addons "OCR Transformer"}}
services:
    transform-ocr:
        image: angelborroy/alfresco-tengine-ocr:1.0.0
        mem_limit: 1536m
        environment:
          JAVA_OPTS: "
              -XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80
              -Dserver.tomcat.threads.max=4
              -Dserver.tomcat.threads.min=1
            "
{{- end}}