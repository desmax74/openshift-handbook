##### login
```console 
eval $(minishift oc-env) 
eval $(minishift docker-env)
oc login -u system:admin
```

#### install kiali
###### prerequisite 
```
envsubst in your path, you can get it via the GNU gettext package
```
##### install 
```console 
scripts/kiali/install_kiali.sh
```
##### console
```
project-> istio-system ->kiali
address will be simlar to https://kiali-istio-system.<ip>.nip.io/console
```

##### uninstall 
```console 
oc delete all,secrets,sa,configmaps,deployments,ingresses,clusterroles,clusterrolebindings,virtualservices,destinationrules,customresourcedefinitions,templates --selector=app=kiali -n istio-system
```