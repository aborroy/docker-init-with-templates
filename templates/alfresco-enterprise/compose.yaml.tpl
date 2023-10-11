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
{{- if eq .Sync "Yes"}}
  - ./sync/compose.yaml
{{- end}}  
  - ./transform/{{.Transform}}/compose.yaml
  - ./search/{{.Search}}/compose.yaml
  - ./db/{{.Database}}/compose.yaml