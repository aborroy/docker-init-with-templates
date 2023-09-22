services:
  content-app:
    image: docker.io/alfresco/alfresco-content-app:${UI_TAG}
    environment:
      APP_BASE_SHARE_URL: "http://localhost:8080/aca/#/preview/s"