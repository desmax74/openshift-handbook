##### With Operator 
```console 
Installed Red-Hat SSO Operator version 7.4.8 from the hub
created Keycloak instance,
created realm rhpam
created roles admin, kie-server, rest-all
created a user called kie with password kie
configure the client settings to use access type confidential, then copy the secret from the section credentials and use in the following yaml
```
Then Insal BA Operator 7.11.1-1 from the hub and created a kieapp with the following yaml

```console 
apiVersion: app.kiegroup.org/v2
kind: KieApp
metadata:
  name: rhpam-sso-test
  namespace: max
  annotations:
    consoleName: snippet-rhpam-sso
    consoleTitle: Configure SSO
    consoleDesc: Use this snippet to configure sso opts
    consoleSnippet: "true"
spec:
  environment: "rhpam-trial"
  auth:
    sso:
      url: https://keycloak-max.apps-crc.testing/auth/
      realm: rhpam
      adminUser: <admin_username>
      adminPassword: <admin_password>
  objects:
    console:
      ssoClient:
        name: kie
        secret: <secret>
    servers:
      - name: kieserver-uno
        deployments: 2
        ssoClient:
          name: kie
          secret: <secret>
      - name: kieserver-due
        ssoClient:
          name: kie
          secret: <secret>
```

on keycloak
```console 
"Valid Redirect URIs" with https://rhpam-sso-prov-rhpamcentr-max.apps-crc.testing/*
```


##### With Templates (Deprecated)
```console 

oc create -f https://raw.githubusercontent.com/jboss-container-images/redhat-sso-7-openshift-image/sso74-dev/templates/sso74-https.json
oc create -f https://raw.githubusercontent.com/jboss-container-images/redhat-sso-7-openshift-image/sso74-dev/templates/sso74-image-stream.json
oc create -f https://raw.githubusercontent.com/jboss-container-images/redhat-sso-7-openshift-image/sso74-dev/templates/sso74-ocp4-x509-https.json
oc create -f https://raw.githubusercontent.com/jboss-container-images/redhat-sso-7-openshift-image/sso74-dev/templates/sso74-ocp4-x509-postgresql-persistent.json
oc create -f https://raw.githubusercontent.com/jboss-container-images/redhat-sso-7-openshift-image/sso74-dev/templates/sso74-postgresql-persistent.json
oc create -f https://raw.githubusercontent.com/jboss-container-images/redhat-sso-7-openshift-image/sso74-dev/templates/sso74-postgresql.json
oc create -f https://raw.githubusercontent.com/jboss-container-images/redhat-sso-7-openshift-image/sso74-dev/templates/sso74-x509-https.json
oc create -f https://raw.githubusercontent.com/jboss-container-images/redhat-sso-7-openshift-image/sso74-dev/templates/sso74-x509-postgresql-persistent.json
```

##### List of templates
```console 
oc get templates 
```
##### New app
```console 
oc new-app --template=sso74-postgresql
```