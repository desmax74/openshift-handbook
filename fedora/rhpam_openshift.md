#### Steps to deploy RHPAM 7.7.7.GA monitoring on CRC 1.8.0 - Openshift 4.3.x with templates

```console
crc start config set memory 16384

oc new-project my-app

docker login -u='<username>' -p=<password>

kubectl create -f ./<secret_from_https://access.redhat.com/>.yaml --namespace=my-app

oc create secret docker-registry red-hat-container-registry \
    --docker-server=registry.redhat.io \
    --docker-username="<username>" \
    --docker-password="<password>" \
    --docker-email="<email>"

oc secrets link builder red-hat-container-registry --for=pull
```

### Import image streams

```console
oc create -f https://raw.githubusercontent.com/jboss-container-images/rhpam-7-openshift-image/7.7.0.GA/rhpam77-image-streams.yaml

oc import-image rhpam-businesscentral-rhel8:7.7.0 —confirm -n my-app

oc import-image rhpam-businesscentral-monitoring-rhel8:7.7.0 —confirm -n my-app

oc import-image rhpam-controller-rhel8:7.7.0 —confirm -n my-app

oc import-image rhpam-kieserver-rhel8:7.7.0 —confirm -n my-app

oc import-image rhpam-smartrouter-rhel8:7.7.0 —confirm -n my-app
```

### Checks Image Streams
```console
oc get is
```
and open on the UI, if the registry isn't accessible patch the registry
```console
oc patch is/rhpam-businesscentral-monitoring-rhel8 --type='json' -p '[{"op": "replace", "path": "/spec/tags/0/from/name", "value": "registry.redhat.io/rhpam-7/rhpam-businesscentral-monitoring-rhel8:7.7.0"}]'
oc patch is/rhpam-businesscentral-rhel8 --type='json' -p '[{"op": "replace", "path": "/spec/tags/0/from/name", "value": "registry.redhat.io/rhpam-7/rhpam-businesscentral-rhel8:7.7.0"}]'
oc patch is/rhpam-controller-rhel8 --type='json' -p '[{"op": "replace", "path": "/spec/tags/0/from/name", "value": "rregistry.redhat.io/rhpam-7/rhpam-controller-rhel8:7.7.0"}]'
oc patch is/rhpam-kieserver-rhel8 --type='json' -p '[{"op": "replace", "path": "/spec/tags/0/from/name", "value": "registry.redhat.io/rhpam-7/rhpam-kieserver-rhel8:7.7.0"}]'
oc patch is/rhpam-smartrouter-rhel8 --type='json' -p '[{"op": "replace", "path": "/spec/tags/0/from/name", "value": "registry.redhat.io/rhpam-7/rhpam-smartrouter-rhel8:7.7.0"}]'
oc patch is/rhpam-process-migration-rhel8 --type='json' -p '[{"op": "replace", "path": "/spec/tags/0/from/name", "value": "registry.redhat.io/rhpam-7/rhpam-process-migration-rhel8:7.7.0"}]'
```


### Importing template

```console
oc create -f https://raw.githubusercontent.com/jboss-container-images/rhpam-7-openshift-image/7.7.0.GA/templates/rhpam77-prod-immutable-monitor.yaml
```

### Secret and service account

```console
oc process -f https://raw.githubusercontent.com/jboss-container-images/rhdm-7-openshift-image/7.7.0.GA/example-app-secret-template.yaml -p SECRET_NAME=automationmanager-app-secret | oc create -f -

oc process -f https://raw.githubusercontent.com/jboss-container-images/rhdm-7-openshift-image/7.7.0.GA/example-app-secret-template.yaml -p SECRET_NAME=businesscentral-app-secret | oc create -f -

oc process -f https://raw.githubusercontent.com/jboss-container-images/rhdm-7-openshift-image/7.7.0.GA/example-app-secret-template.yaml -p SECRET_NAME=kieserver-app-secret | oc create -f -

oc process -f https://raw.githubusercontent.com/jboss-container-images/rhdm-7-openshift-image/7.7.0.GA/example-app-secret-template.yaml -p SECRET_NAME=kieserver-router-secret | oc create -f -

oc process -f https://raw.githubusercontent.com/jboss-container-images/rhdm-7-openshift-image/7.7.0.GA/example-app-secret-template.yaml -p SECRET_NAME=smartrouter-app-secret | oc create -f -

oc process -f https://raw.githubusercontent.com/jboss-container-images/rhdm-7-openshift-image/7.7.0.GA/example-app-secret-template.yaml -p SECRET_NAME=controller-app-secret | oc create -f -

oc process -f https://raw.githubusercontent.com/jboss-container-images/rhdm-7-openshift-image/7.7.0.GA/example-app-secret-template.yaml -p SECRET_NAME=businesscentral-monitoring-app-secret | oc create -f -

oc create -f ./../scripts/rhpam/credentials.yaml
```

### Deploy template

```console
oc new-app --template=rhpam77-prod-immutable-monitor -p APPLICATION_NAME="my-rhpam-app" \ 
        -p IMAGE_STREAM_NAMESPACE="my-app" -p CREDENTIALS_SECRET="rhpam-credentials" \ 
        -p MAVEN_REPO_USERNAME="dmAdmin" -p MAVEN_REPO_PASSWORD="redhatdm1!" \ 
        -p KIE_SERVER_ROUTER_HTTPS_SECRET="kieserver-router-secret" \ 
        -p BUSINESS_CENTRAL_HTTPS_SECRET="businesscentral-app-secret"
```


```console
oc new-app -f rhpam77-prod-immutable-kieserver.yaml -p CREDENTIALS_SECRET=rhpam-credentials \
       -p KIE_SERVER_MONITOR_SERVICE=my-rhpam-app-rhpamcentrmon \
       -p KIE_SERVER_ROUTER_SERVICE=my-rhpam-app-smartrouter \
       -p SOURCE_REPOSITORY_URL=https://example.com/xxxx.git -p CONTEXT_DIR=rootDir \
       -p KIE_SERVER_CONTAINER_DEPLOYMENT=containerId=G:A:V
```

Checks Deployment configs
```console
oc get dc
```

Deploy DC
```console
oc rollout latest dc/my-rhpam-app-rhpamcentrmon -n my-app
oc rollout latest dc/my-rhpam-app-smartrouter -n my-app
```
if you see ann error message like

```console
Error from server (BadRequest): cannot trigger a deployment for "my-rhpam-app-rhpamcentrmon" because it contains unresolved images
```

checks the following item in the UI:
DeploymentConfig namespace (change if you have openshift default namespace with your namespace)
 ```console
spec:
  strategy:
    type: Rolling
    rollingParams:
      updatePeriodSeconds: 1
      intervalSeconds: 1
      timeoutSeconds: 600
      maxUnavailable: 0
      maxSurge: 100%
    resources: {}
    activeDeadlineSeconds: 21600
  triggers:
    - type: ImageChange
      imageChangeParams:
        automatic: true
        containerNames:
          - my-rhpam-app-rhpamcentrmon
        from:
          kind: ImageStreamTag
          namespace: my-app
          name: 'rhpam-businesscentral-monitoring-rhel8:7.7.0' 
```

 and template (templateInstances in your namespace)
 (change if you have openshift default namespace with your namespace)
 ```console
 
 spec:
  template:
    metadata:
      name: rhpam77-prod-immutable-monitor
      namespace: my-app
```