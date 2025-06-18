{{/* Return the full name for this chart */}}
{{- define "moderation.fullname" -}}
{{- printf "%s-%s" .Release.Name "moderation" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Common labels */}}
{{- define "moderation.labels" -}}
app.kubernetes.io/name: {{ include "moderation.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
