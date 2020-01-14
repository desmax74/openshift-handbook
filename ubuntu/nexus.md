### Sonatype Nexus 3:
Persistent
```console
oc new-project nexus
$ oc create -f https://raw.githubusercontent.com/monodot/openshift-nexus/master/nexus3-persistent-template.yaml
$ oc new-app nexus3-persistent NEXUS_VERSION=3.20.1
```

Ephemeral
```console
oc new-project nexus
$ oc create -f https://raw.githubusercontent.com/OpenShiftDemos/nexus/master/nexus3-template.yaml
$ oc new-app nexus3 -p NEXUS_VERSION=3.20.1
```
