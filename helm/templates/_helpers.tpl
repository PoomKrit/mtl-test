{{/*
Create a full name for resources
*/}}
{{- define "go-application.fullname" -}}
{{- default .Chart.Name .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "go-application.labels" -}}
app.kubernetes.io/name: {{ include "go-application.fullname" . }}
helm.sh/chart: {{ include "go-application.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.commonLabels }}
{{- toYaml .Values.commonLabels | nindent 4 }}
{{- end }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "go-application.selectorLabels" -}}
app.kubernetes.io/name: {{ include "go-application.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Chart label
*/}}
{{- define "go-application.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" -}}
{{- end -}}
