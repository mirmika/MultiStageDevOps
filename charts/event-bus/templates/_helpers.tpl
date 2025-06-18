{{/* 
Return the fully-qualified name for this chart 
*/}}
{{- define "event-bus.fullname" -}}
{{- printf "%s-%s" .Release.Name "event-bus" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Shortcut for chart labels */}}
{{- define "event-bus.labels" -}}
app.kubernetes.io/name: {{ include "event-bus.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
