# Usage

Welcome to your Alfresco Enterprise {{.Version}} Docker Compose deployment!

Before executing this installer be sure that Docker is running in your computer.

Docker Images from [quay.io](https://quay.io/organization/alfresco) are used, since this product is only available for Alfresco Enterprise customers. If you are Enterprise Customer or Partner but you are still experimenting problems to download Docker Images, contact [Alfresco Hyland Support](https://community.hyland.com) in order to get required credentials and permissions.

When Docker is up & ready, verify that 12 GB of Memory are available. 

## Starting Alfresco

Start Alfresco using the command `docker compose up`

Once the platform is ready, you will find a line similar to the following one in the terminal:
```
alfresco-1 | org.apache.catalina.startup.Catalina.start Server startup in [NNNNN] milliseconds
```
## Service URLs

   * UI: http://localhost:8080/workspace/
   * Control Center: http://localhost:8080/admin/
{{- if eq .LegacyUI "Yes"}}
   * Legacy UI: http://localhost:8080/share
{{- end}}   
   * Repository (REST API): http://localhost:8080/alfresco
{{- if eq .Messaging "Yes"}}
   * ActiveMQ (Messaging API): tcp://localhost:61616
  {{- if eq .MessagingCredentials "Yes"}}    
      * username: "{{.MessagingUser}}"
      * password: "{{.MessagingPassword}}"
  {{- end}}   
{{- end}}   

Remember to use following credentials:

   * username: admin
   * password: admin

## Stopping

Alfresco can be stopped typing `Ctrl+C` in the terminal used to start the Docker Compose.

If you want to start again Alfresco, type `docker compose up` from the folder used to produce the configuration.