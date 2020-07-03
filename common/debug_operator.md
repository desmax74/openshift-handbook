### CRC
First create yourname namespace if isn't exists yet e.g. playground
start crc and login from cli as kubeadmin

### IDE
On your ide create a remote debug profile 
with host= localhost
and port= 2345

#### DLV
```console 
go get -u github.com/go-delve/delve/cmd/dlv
```

#### CLI 
```console 

# Export the ENV VAR WATCH_NAMESPACE 
$ export WATCH_NAMESPACE=playground

# Install the CRD's of your operator project
$ kubectl create -f deploy/crds/myoperator_v1alpha1_kind_crd.yaml

# Go to the dir where is placed the main.go file
$ cd cmd/manager/

# Run the following command
$ dlv debug --headless --listen=:2345 --api-version=2
```

#### Debug reconcile
To debug code other main.go
create a kieapp (in case of kie-cloud-operator)
i.e.
```console 
oc create -f deploy/crs/v2/kieapp_rhpam_production.yaml
```

To test again, go in the Openshift console in Administration->Custom Resource Definitions -> KieApp - >instances