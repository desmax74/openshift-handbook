Prerequisites

##### 1)
CRC up and running with internal registry exposed, see: ./expose_registry_ocp4.md

##### 2) 
Build you operator then tag you image with the address of image registry and then push

##### Deploy
Align metadata name in the files

cluster_role.yaml
cluster_role_binding.yaml
role.yaml
role_binding.yaml
service_account.yaml

from kie-cloud-operator to business-automation-operator

in deploy folder https://github.com/desmax74/kie-cloud-operator/tree/main/deploy

install
create service acc -> create roles -> create roles binding -> create operator

kubectl create -f deploy/service_account.yaml
kubectl create -f deploy/role.yaml
kubectl create -f deploy/role_binding.yaml


Change the operator.yaml with the images in your local registry
image-registry.openshift-image-registry.svc:5000/max/<image>@sha
available from the imagestreams 

then 
kubectl create -f deploy/operator.yaml

then go to routes
console-cr-form (url like https://console-cr-form-max.apps-crc.testing/)