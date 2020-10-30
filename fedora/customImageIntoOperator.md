Top test your images in a deploy i.e using the BA operator 

```console 
apiVersion: app.kiegroup.org/v2
kind: KieApp
metadata: 
  name: rhpam-authoring
spec: 
  commonConfig: 
    adminUser: admin
    adminPassword: foobar$0
    dbPassword: foobar$0
  environment: rhpam-authoring
  objects: 
    servers: 
      - database: 
          size: 1Gi
          type: postgresql
  useImageTags: true
```


##### Change the stream with your image
Builds->image streams
open the yaml of the pod you want to update
then when you save you see the update  in the items, the pod will be retriggered

```console 
spec:
  lookupPolicy:
    local: false
  tags:
    - name: 7.8.1
      annotations: null
      from:
        kind: DockerImage
        name: 'quay.io/desmax74/rhpam-kieserver-rhel8:7.10.0'
      generation: 4
      importPolicy: {}
      referencePolicy:
        type: Local
status:
  dockerImageRepository: 'image-registry.openshift-image-registry.svc:5000/max/rhpam-kieserver-rhel8'
  publicDockerImageRepository: >-
    default-route-openshift-image-registry.apps.playground.rhba.openshift-psi.rhocf-dev.net/max/rhpam-kieserver-rhel8
  tags:
    - tag: 7.8.1
      items:
        - created: '2020-10-30T12:26:41Z'
          dockerImageReference: >-
            quay.io/desmax74/rhpam-kieserver-rhel8@sha256:7e206e7d4ddbeb850d811bb74dbd3c09114bd0eb5dc224614dc56faecc5c09e8
          image: >-
            sha256:7e206e7d4ddbeb850d811bb74dbd3c09114bd0eb5dc224614dc56faecc5c09e8
          generation: 4
        - created: '2020-10-30T12:06:39Z'
          dockerImageReference: >-
            registry.redhat.io/rhpam-7/rhpam-kieserver-rhel8@sha256:5d70a505d5850e8a845133a17dc9301a3a800c580681483958ebdce349d84f19
          image: >-
            sha256:5d70a505d5850e8a845133a17dc9301a3a800c580681483958ebdce349d84f19
          generation: 2
```

https://console-openshift-console.apps.playground.rhba.openshift-psi.rhocf-dev.net/k8s/ns/max/imagestreams