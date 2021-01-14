#### Login on ocp
```
oc login --token=<token> --server=https://<server_address>:6443
```

#### Set DefaultRoute to True
```
oc patch configs.imageregistry.operator.openshift.io/cluster --patch '{"spec":{"defaultRoute":true}}' --type=merge
```

#### Login 
```
HOST=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')
```

##### podman
```
podman login -u $(oc whoami) -p $(oc whoami -t) --tls-verify=false $HOST 
```
##### docker
```
docker login -u $(oc whoami) -p $(oc whoami -t) $HOST
```

##### Tag your local image with ocp address
```
docker tag pippo-7/pippo-mybiz-centos8:5.10.0 <server_address>/max/pippo-mybiz-centos8:5.10.0
```
##### Push image
```
docker push <server_address>/max/pippo-mybiz-centos8:5.10.0
```

##### Show images
Go to Project -> builds -> imagestreams

##### Troubleshoot x509: certificate signed by unknown authority
If during docker login the response is x509
```
docker login -u kubeadmin -p $(oc whoami -t) default-route-openshift-image-registry.apps-crc.testing
```

First extract the cert with:
```
oc extract secret/router-ca --keys=tls.crt -n openshift-ingress-operator
```

create the dir if isn't present
```
mkdir /etc/docker/certs.d/default-route-openshift-image-registry.apps-crc.testing/
```

and copy the cert inside
```
cp tls.crt /etc/docker/certs.d/default-route-openshift-image-registry.apps-crc.testing/
```

then login again
```
docker login -u kubeadmin -p $(oc whoami -t) default-route-openshift-image-registry.apps-crc.testing
```