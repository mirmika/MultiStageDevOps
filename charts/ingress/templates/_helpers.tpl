{{/* Generate a fullname: "<release-name>-ingress" truncated to 63 chars */}}
{{- define "ingress.fullname" -}}
{{- printf "%s-ingress" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}