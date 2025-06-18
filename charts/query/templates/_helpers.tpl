{{/* Return the full name for this chart */}}
{{- define "query.fullname" -}}
{{- printf "%s-%s" .Release.Name "query" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Common labels */}}
{{- define "query.labels" -}}
app.kubernetes.io/name: {{ include "query.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
