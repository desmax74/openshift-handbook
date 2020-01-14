### Sonatype Nexus 3:

```console
oc new-project nexus
$ oc create -f https://raw.githubusercontent.com/monodot/openshift-nexus/master/nexus3-persistent-template.yaml
$ oc new-app nexus3-persistent
```
