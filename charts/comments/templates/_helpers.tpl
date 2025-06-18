{{- define "mychart.fullname" -}}
{{- /* combine the release name + svc and truncate to 63 chars */ -}}
{{- printf "%s-%s" .root.Release.Name .svc | trunc 63 | trimSuffix "-" -}}
{{- end -}}
