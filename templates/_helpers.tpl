{{/*
Expand the name of the chart.
*/}}
{{- define "bonita.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bonita.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "bonita.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "bonita.labels" -}}
helm.sh/chart: {{ include "bonita.chart" . }}
{{ include "bonita.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "bonita.selectorLabels" -}}
app.kubernetes.io/name: {{ include "bonita.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "bonita.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "bonita.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Custom data
*/}}

{{/*
Return platform password
*/}}
{{- define "bonita.platformPassword" -}}
{{- if .Values.credentials.platformPassword }}
    {{- .Values.credentials.platformPassword -}}
{{- else -}}
    {{- randAlphaNum 10 -}}
{{- end -}}
{{- end -}}

{{/*
Return tenant password
*/}}
{{- define "bonita.tenantPassword" -}}
{{- if .Values.credentials.tenantPassword }}
    {{- .Values.credentials.tenantPassword -}}
{{- else -}}
    {{- randAlphaNum 10 -}}
{{- end -}}
{{- end -}}

{{/*
Return the bonita database name
*/}}
{{- define "bonita.bonitaDb.database" -}}
    {{- if .Values.credentials.bonitaDatabase.database -}}
        {{- printf "%s" .Values.credentials.bonitaDatabase.database -}}
    {{- else }}
        {{- printf "bonitadb" -}}
    {{- end -}}
{{- end -}}

{{/*
Return the bonita database user
*/}}
{{- define "bonita.bonitaDb.user" -}}
    {{- if .Values.credentials.bonitaDatabase.user -}}
        {{- printf "%s" .Values.credentials.bonitaDatabase.user -}}
    {{- else  }}
        {{- printf "bonitauser" -}}
    {{- end -}}
{{- end -}}

{{/*
Return bonita database  password
*/}}
{{- define "bonita.bonitaDb.password" -}}
{{- if .Values.credentials.bonitaDatabase.password }}
    {{- .Values.credentials.bonitaDatabase.password -}}
{{- else -}}
    {{- randAlphaNum 10 -}}
{{- end -}}
{{- end -}}

{{/*
Return the business database name
*/}}
{{- define "bonita.businessDb.database" -}}
    {{- if .Values.credentials.businessDatabase.database -}}
        {{- printf "%s" .Values.credentials.businessDatabase.database -}}
    {{- else  }}
        {{- printf "businessdb" -}}
    {{- end -}}
{{- end -}}

{{/*
Return the business database user
*/}}
{{- define "bonita.businessDb.user" -}}
    {{- if .Values.credentials.businessDatabase.user -}}
        {{- printf "%s" .Values.credentials.businessDatabase.user -}}
    {{- else  }}
        {{- printf "businessuser" -}}
    {{- end -}}
{{- end -}}

{{/*
Return bonita business database password
*/}}
{{- define "bonita.businessDb.password" -}}
{{- if .Values.credentials.businessDatabase.password }}
    {{- .Values.credentials.businessDatabase.password -}}
{{- else -}}
    {{- randAlphaNum 10 -}}
{{- end -}}
{{- end -}}

{{/*
Return the bonita credentials secret name
*/}}
{{- define "bonita.credentialsSecretName" -}}
{{- if .Values.existingBonitaCredentialsSecret -}}
    {{- printf "%s" (tpl .Values.existingBonitaCredentialsSecret $) -}}
{{- else -}}
    {{- printf "%s-credentials" (include "bonita.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name for postgresql.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "bonita.postgresql.fullname" -}}
{{- include "common.names.dependency.fullname" (dict "chartName" "postgresql" "chartValues" .Values.postgresql "context" $) -}}
{{- end -}}

{{/*
Return the name of the database host
*/}}
{{- define "bonita.postgresHost" -}}
{{- if .Values.postgresql.enabled }}
    {{- printf "%s" (include "bonita.postgresql.fullname" .) -}}
{{- else -}}
    {{- printf "%s" .Values.externalDatabase.host -}}
{{- end -}}
{{- end }}

{{/*
Return the database port
*/}}
{{- define "bonita.postgresPort" -}}
{{- if .Values.postgresql.enabled }}
    {{- printf "5432" -}}
{{- else -}}
    {{- printf "%d" (.Values.externalDatabase.port | int ) -}}
{{- end -}}
{{- end -}}

{{/*
Return the database user
*/}}
{{- define "bonita.postgresUser" -}}
{{- if .Values.postgresql.enabled }}
    {{- printf "%s" .Values.postgresql.postgresqlUsername -}}
{{- else -}}
    {{- printf "%s" .Values.externalDatabase.user -}}
{{- end -}}
{{- end -}}

{{/*
Return the database secret Name
*/}}
{{- define "bonita.postgresSecretName" -}}
{{- if .Values.postgresql.enabled }}
    {{- if .Values.postgresql.existingSecret -}}
        {{- printf "%s" .Values.postgresql.existingSecret -}}
    {{- else -}}
        {{- printf "%s" (include "bonita.postgresql.fullname" .) -}}
    {{- end -}}
{{- else if .Values.externalDatabase.existingSecret -}}
    {{- printf "%s" .Values.externalDatabase.existingSecret -}}
{{- else -}}
    {{- printf "%s-externaldb" (include "bonita.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return the database vendor
*/}}
{{- define "bonita.dbVendor" -}}
{{- if .Values.postgresql.enabled }}
    {{- printf "postgres" -}}
{{- else -}}
    {{- printf "%s" .Values.externalDatabase.type -}}
{{- end -}}
{{- end -}}
