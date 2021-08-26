Prerequisites

##### CRC UP with registry exposed
CRC up and running with internal registry exposed, see: ./expose_registry_ocp4.md

##### Build operator
Build you operator then tag you image with the address of image registry and then push
and change in the deploy/operator.yaml something like
```console 
image: image-registry.openshift-image-registry.svc:5000/max/kie-cloud-operator@sha256:8240943bafd6f38b37815304e0b6d16e7d8e25b8970c7f987cb2d63c17bfdf36
```

##### Deploy
Align metadata name in the files
```console 
cluster_role.yaml
cluster_role_binding.yaml
role.yaml
role_binding.yaml
service_account.yaml
```

from kie-cloud-operator to business-automation-operator

in deploy folder https://github.com/desmax74/kie-cloud-operator/tree/main/deploy

install
create service acc -> create roles -> create roles binding -> create operator
```console 
kubectl create -f deploy/crds/kieapp.crd.yaml
kubectl create -f deploy/service_account.yaml
kubectl create -f deploy/role.yaml
kubectl create -f deploy/role_binding.yaml
```

Change the operator.yaml with the images in your local registry
image-registry.openshift-image-registry.svc:5000/max/<image>@sha
available from the imagestreams
then 
```console 
kubectl create -f deploy/operator.yaml
```
then go to routes
console-cr-form (url like https://console-cr-form-max.apps-crc.testing/)
