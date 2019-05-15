##### login
```console 
eval $(minishift oc-env) 
eval $(minishift docker-env)
oc login -u system:admin
```

### Istio 1.1.1
#### Istio
```console 
curl -L https://github.com/istio/istio/releases/download/1.1.1/istio-1.1.1-linux.tar.gz | tar xz
```


#### Fix elasticsearch
```console 
oc apply -f install/kubernetes/helm/istio-init/files/crd-11.yaml
oc apply -f install/kubernetes/istio-demo.yaml
oc project istio-system
oc expose svc istio-ingressgateway
oc expose svc grafana
oc expose svc prometheus
oc expose svc tracing
oc expose service kiali --path=/kiali
oc adm policy add-cluster-role-to-user admin system:serviceaccount:istio-system:kiali-service-account -z default
```


###### wait the components to be ready
```console 
oc get pods -w
```


###### wWait for Istio’s components to be ready
```console 
oc get pods -n istio-system
```