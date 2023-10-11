services:
  digital-workspace:
    image: quay.io/alfresco/alfresco-digital-workspace:${ADW_TAG}
    mem_limit: 128m
    environment:
      APP_CONFIG_AUTH_TYPE: "BASIC"
      APP_CONFIG_PROVIDER: "ECM"
      BASE_PATH: ./
      APP_BASE_SHARE_URL: "http://localhost:8080/workspace/#/preview/s"
  control-center:
    image: quay.io/alfresco/alfresco-control-center:${CONTROL_CENTER_TAG}
    mem_limit: 128m
    environment:
      APP_CONFIG_PROVIDER: "ECM"
      APP_CONFIG_AUTH_TYPE: "BASIC"
      BASE_PATH: ./      