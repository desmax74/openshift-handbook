#### Steps to deploy RHPAM 7.7.7.GA monitoring - Openshift 4.3.x with templates


##### Start CRC 1.8.0
```console
crc start config set memory 16384
```

##### Login
```console
oc login https://<url>:8443 -u admin -p admin
```

### Create the namespace
```console
oc new-project my-app
```

### Registries login
```console
docker login -u='<username>' -p=<password>

kubectl create -f ./<secret_from_https://access.redhat.com/>.yaml --namespace=my-app
```

### Credentials
```console
oc create -f installation/credentials.yaml

```

### App secrets

one for all, just for development
```console
oc process -f https://raw.githubusercontent.com/jboss-container-images/rhdm-7-openshift-image/7.7.0.GA/example-app-secret-template.yaml -p SECRET_NAME=app-secret | oc create -f -
```
one for each but with the same credentials, change to have one for each
```console
oc process -f https://raw.githubusercontent.com/jboss-container-images/rhdm-7-openshift-image/7.7.0.GA/example-app-secret-template.yaml -p SECRET_NAME=automationmanager-app-secret | oc create -f -
oc process -f https://raw.githubusercontent.com/jboss-container-images/rhdm-7-openshift-image/7.7.0.GA/example-app-secret-template.yaml -p SECRET_NAME=businesscentral-app-secret | oc create -f -
oc process -f https://raw.githubusercontent.com/jboss-container-images/rhdm-7-openshift-image/7.7.0.GA/example-app-secret-template.yaml -p SECRET_NAME=kieserver-app-secret | oc create -f -
oc process -f https://raw.githubusercontent.com/jboss-container-images/rhdm-7-openshift-image/7.7.0.GA/example-app-secret-template.yaml -p SECRET_NAME=kieserver-router-secret | oc create -f -
oc process -f https://raw.githubusercontent.com/jboss-container-images/rhdm-7-openshift-image/7.7.0.GA/example-app-secret-template.yaml -p SECRET_NAME=smartrouter-app-secret | oc create -f -
oc process -f https://raw.githubusercontent.com/jboss-container-images/rhdm-7-openshift-image/7.7.0.GA/example-app-secret-template.yaml -p SECRET_NAME=controller-app-secret | oc create -f -
oc process -f https://raw.githubusercontent.com/jboss-container-images/rhdm-7-openshift-image/7.7.0.GA/example-app-secret-template.yaml -p SECRET_NAME=automationmanager-app-secret | oc create -f -

```

### Import image streams

```console
oc create -f https://raw.githubusercontent.com/jboss-container-images/rhpam-7-openshift-image/7.7.0.GA/rhpam77-image-streams.yaml

```