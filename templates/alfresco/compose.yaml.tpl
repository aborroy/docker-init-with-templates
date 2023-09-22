include:
  - ./proxy/compose.yaml
  - ./ui/compose.yaml
{{- if eq .LegacyUI "Yes"}}
  - ./legacy-ui/compose.yaml
{{- end}}
  - ./repo/compose.yaml
{{- if eq .Messaging "Yes"}}
  - ./messaging/compose.yaml
{{- end}}  
  - ./transform/compose.yaml
  - ./search/compose.yaml
  - ./db/compose.yaml