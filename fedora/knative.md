#### Start minishift 
[reviews amount of ram and cpu (by default are 8gb and 3 cpu)]
```console 
scripts/knative/minishift_knative_start.sh
```
```console 
eval $(minishift docker-env) 
eval $(minishift oc-env)
```

### Knative setup
Login as admin
```console 
oc login -u admin -p admin
```

#### Admission Controller Webhook
Allowing few minutes, at the end of the script ,for the OpenShift to be restarted
```console 
scripts/knative/admission_controller_web_hook.sh
```

## Install Istio
##### Istio policies
```console 
scripts/knative/istio_policies.sh
```
##### Deploy istio
```console 
curl -L https://github.com/knative/serving/releases/download/v0.3.0/istio.yaml sed 's/LoadBalancer/NodePort/' | kubectl apply --filename -
```
#####Update Istio sidecar injector ConfigMap
##### Important: run only one for minishift instance
```console 
oc apply -n istio-system -f scripts/knative/istio-sidecar-injector.yaml
```
##### Checks the components
```console 
oc get pods -n istio-system -w
```

#### Install Knative Build
```console 
scripts/knative/knative_build.sh
```
Checks pods' status
```console 
oc get pods -n knative-build -w
```

#### Install Knative serving
```console 
scripts/knative/knative_serving.sh
```
Checks pods' status
```console 
oc get pods -n knative-serving -w
```

#### Install Knative eventing
```console 
scripts/knative/knative_eventing.sh
```
Checks pods' status
```console 
oc get pods -n knative-eventing -w
```
Checks pods' status
```console 
oc get pods -n knative-eventing -w
oc get pods -n knative-sources -w
```
