{{/* Return the full name for this chart */}}
{{- define "posts.fullname" -}}
{{- printf "%s-%s" .Release.Name "posts" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Common labels */}}
{{- define "posts.labels" -}}
app.kubernetes.io/name: {{ include "posts.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
