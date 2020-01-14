### Sonatype Nexus 3:
```console
oc create -f https://raw.githubusercontent.com/OpenShiftDemos/nexus/master/nexus3-template.yaml
```
```console
oc new-app nexus3
```
or
```console
oc new-app nexus3-persistent
```
specific version
```console
oc new-app nexus3 -p NEXUS_VERSION=3.5.2
```