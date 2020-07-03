### CRC
First create yourname namespace if isn't exists yet e.g. playground
start crc and login from cli as kubeadmin

### IDE
On your ide create a remote debug profile 
with host= localhost
and port= 2345

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
