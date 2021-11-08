# Bonita Helm Chart

This chart bootstraps a [Bonita Runtime](https://documentation.bonitasoft.com/bonita/2021.1/what-is-bonita) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.1.0

## Installing the Chart
To install the chart with the release name `my-release`:

```console
$ helm install my-release .
```

The command deploys Bonita Docker image on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components of the helm release.

## Parameters

## Common parameters

| Name                                            | Description                                                                       | Default                     |
| ----------------------------------------------- | --------------------------------------------------------------------------------- | --------------------------- |
| `replicaCount`                                  | Specify the initial number of replicas for the Bonita Pods                        | `1`                         |
| `image.repository`                              | Bonita image repository                                                           | `bonita`                    |
| `image.tag`                                     | Bonita image tag (immutable tags are recommended)                                 | `7.13.0`                    |
| `image.pullPolicy`                              | Bonita image pull policy                                                          | `IfNotPresent`              |
| `image.pullSecret`                              | Specify image pull secrets                                                        | `[]`                        |
| `initScriptsConfigMapName`                      | Specify the name of a confimap containing init scripts                            | `""`                        |
| `nameOverride`                                  | Provide a name in place of bonia                                                  | `""`                        |
| `fullnameOverride`                              | Provide a name to substitute for the full names of resources                      | `""`                        |
| `serviceAccount.create`                         | Create a serviceaccount                                                           | `false`                     |
| `serviceAccount.name`                           | Specify the name of the service account                                           | `""`                        |
| `podAnnotations`                                | Annotations to add to the bonita pod                                              | `{}`                        |
| `podSecurityContext`                            | SecurityContext to add to the bonita pod                                           | `{}`                       |
| `securityContext`                               | SecurityContext to add to the bonita container                                     | `{}`                       |
| `service.type`                                  | Specify the service type (ClusterIP, LoadBalancer, NodePort, etc...)              | `"ClusterIP"`               |
| `service.port`                                  | Specify the service port                                                          | `"80"`                      |
| `ingress.enabled`                               | If true, Bonita Ingress will be created                                           | `true`                      |
| `ingress.className`                             | Name of Priority Class to assign ingress                                          | `""`                        |
| `ingress.annotations`                           | Annotations to be added to the Bonita ingress                                     | `{}`                        |
| `ingress.hosts`                                 | Bonita Ingress hostnames                                                          | `[]`                        |
| `ingress.tls`                                   | Bonita Ingress TLS configuration                                                  | `{}`                        |
| `resources`                                     | Resource limits for Bonita pods                                                   | `{}`                        |
| `autoscaling.enabled`                           | If true, a horizontal pod autoscaler will be created                              | `false`                     |
| `autoscaling.minReplicas`                       | Minimum number of replicas for horizontal pod autoscaler                          | `1`                         |
| `autoscaling.maxReplicas`                       | Maximum number of replicas for horizontal pod autoscaler                          | `100`                       |
| `autoscaling.targetCPUUtilizationPercentage`    | Threshold of the average use of the CPU for horizontal pod autoscaler             | `80`                        |
| `autoscaling.targetMemoryUtilizationPercentage` | Threshold of the average use of the memory for horizontal pod autoscaler          | `""`                        |
| `nodeSelector`                                  | Node selector for Bonita pods ([doc](https://kubernetes.io/docs/user-guide/node-selection/))| `{}`              |
| `tolerations`                                   | Tolerations for Bonita pods ([doc](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/))| `{}`|
| `affinity`                                      | Assign custom affinity rules to the Bonita pods                                   | `{}`                        |


### Credentials parameters

| Name                                            | Description                                                                       | Default                     |
| ----------------------------------------------- | --------------------------------------------------------------------------------- | --------------------------- |
| `credentials.tenantLogin`                       | Username for the Bonita tenant administrator.                                     | `install`                   |
| `credentials.tenantPassword`                    | Password for the Bonita tenant administrator                                      | `install`                   |
| `credentials.platformLogin`                     | Username for the Bonita platform administrator                                    | `platformAdmin`             |
| `credentials.platformPassword`                  | Password for the Bonita platform administrator                                    | `platform`                  |
| `credentials.bonitaDatabase.database`           | Database name for the Bonita main database                                        | `bonitadb`                  |
| `credentials.bonitaDatabase.user`               | Database user for the Bonita main database                                        | `bonitauser`                |
| `credentials.bonitaDatabase.password`           | Database password for the Bonita main database                                    | `bonitapass`                |
| `credentials.businessDatabase.database`         | Database name for the Bonita business database                                    | `businessdb`                |
| `credentials.businessDatabase.user`             | Database user for the Bonita business database                                    | `businessuser`              |
| `credentials.businessDatabase.password`         | Database password for the Bonita business database                                | `businesspass`              |


### Postgresql deployment parameters

[See the complete documentation here](https://github.com/bitnami/charts/tree/master/bitnami/postgresql)

| Name                                            | Description                                                                       | Default                     |
| ----------------------------------------------- | --------------------------------------------------------------------------------- | --------------------------- |
| `postgresql.enabled`                            | Deploy a PostgreSQL server to satisfy the applications database requirements      | `true`                      |
| `postgresql.image.debug`                        | Specify if debug values should be set                                             | `false`                     |
| `postgresql.postgresqlUsername`                 | PostgreSQL user (has superuser privileges if username is `postgres`)              | `postgres`                  |
| `postgresql.postgresqlPassword`                 | PostgreSQL user password                                                          | `postgres`                  |
| `postgresql.postgresqlPostgresPassword`         | PostgreSQL admin password (used when `postgresqlUsername` is not `postgres`, in which case`postgres` is the admin username) |`""`|
| `postgresql.existingSecret`                     | Name of existing secret to use for PostgreSQL passwords                           | `""`                        |
| `postgresql.postgresqlExtendedConf`             | Extended Runtime Config Parameters (appended to main or default configuration)    |`{maxPreparedTransactions: 100}`|


### External database parameters

| Name                                            | Description                                                                       | Default                     |
| ----------------------------------------------- | --------------------------------------------------------------------------------- | --------------------------- |
| `externalDatabase.enabled`                      | Enable using a external database                                                  | `false`                     |
| `externalDatabase.type`                         | External database type (possible values : h2, postgres, mysql)                    | `postgres`                  |
| `externalDatabase.host`                         | External Database server host                                                     | `localhost`                 |
| `externalDatabase.port`                         | External Database server port                                                     | `5432`                      |
| `externalDatabase.user`                         | External Database server user                                                     | `bonitasoft`                |
| `externalDatabase.password`                     | External Database user password                                                   | `postgres`                  |
| `externalDatabase.existingSecret`               | The name of an existing secret with database credentials                          | `""`                        |


Specify each parameter using the `--set key=value` argument to `helm install`. For example,

```console
$ helm install my-release . \
--set credentials.tenantPassword=supertenantpassword\
--set credentials.platformPassword=superadminpassword
```

The above command sets the tenant and platform passwords

> NOTE: Once this chart is deployed, it is not possible to change the application's access credentials, such as usernames or passwords, using Helm. To change these application credentials after deployment, delete any persistent volumes (PVs) used by the postgresql and re-deploy it or drop external databases if you have `externalDatabase.enabled`. 

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install my-release . -f values.yaml
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Configuration

### Secure installation

Before deploying to production, make sure you have replaced all sensitive information such as usernames and passwords in the values.yaml file 

```yaml
credentials:
  tenantLogin: "my_custom_tenant_user"
  tenantPassword: "my_custom_tenant_password"

  platformLogin: "my_custom_platform_user"
  platformPassword: "my_custom_platform_password"

  bonitaDatabase:
    user: "my_custom_bonita_database_user"
    password: "my_custom_bonita_database_password"

  businessDatabase:
    user: "my_custom_business_database_user"
    password: "my_custom_business_database_password"

postgresql:
  postgresqlUsername: "my_custom_postgresql_admin_username"
  postgresqlPassword: "my_custom_postgresql_admin_password"
```

### Auto scaling

You can enable autoscaling by configuring it through the values.yaml file: 

```yaml
autoscaling:
  enabled: true
  minReplicas: 5
  maxReplicas: 50
  targetCPUUtilizationPercentage: 80
```

### Custom init scripts

Custom initialization scripts are invoked once the database has been initialized and the Tomcat server has been configured with Bonita Platform setup tool.

Hence the Bonita Docker image startup sequence can be described as follows:
1. Initialize database: setup.sh init
2. Configure Tomcat server: setup.sh configure
3. Execute custom initialization *.sh scripts found in the container’s /opt/custom-init.d folder
4. Start Tomcat server

To inject a script with the Helm Chart, you can create a configmap that contains your script and specify the configmap name in the initscriptsConfigMap variable in the values.yaml file.

For example we will make a script that replaces all INFO logs levels to WARNING: 

Create init-script-configmap.yaml file:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: init-scripts
data:
  init-script.sh: |-
    #!/bin/sh
    sed -i "s/INFO/WARNING/g" /opt/bonita/*/server/conf/logging.properties
```

Deploy the configmap and the Helm Chart while specifying the configmap name in the initScriptsConfigMapName variable :

```console
$ kubectl apply -f init-script-configmap.yaml

$ helm install my-release . --set initScriptsConfigMapName=init-scripts
```

