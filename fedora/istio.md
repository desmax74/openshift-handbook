##### login
```console 
eval $(minishift oc-env) 
eval $(minishift docker-env)
oc login $(minishift ip):8443 -u admin -p admin
```

### Istio 1.0.5
#### Install service mesh
```console 
minishift openshift config set --target=kube --patch '{
    "admissionConfig": {
        "pluginConfig": {
            "ValidatingAdmissionWebhook": {
                "configuration": {
                    "apiVersion": "apiserver.config.k8s.io/v1alpha1",
                    "kind": "WebhookAdmission",
                    "kubeConfigFile": "/dev/null"
                }
            },
            "MutatingAdmissionWebhook": {
                "configuration": {
                    "apiVersion": "apiserver.config.k8s.io/v1alpha1",
                    "kind": "WebhookAdmission",
                    "kubeConfigFile": "/dev/null"
                }
            }
        }
    }
}'
```

#### Fix elasticsearch
```console 
$ minishift ssh
[docker@istio-tutorial ~]$ sudo -i
[root@istio-tutorial ~]$ echo "vm.max_map_count = 262144" > /etc/sysctl.d/99-elasticsearch.conf
[root@istio-tutorial ~]$ sysctl vm.max_map_count=262144
[root@istio-tutorial ~]$ exit
logout
[docker@istio-tutorial ~]$ exit
logout
```

### Istio
```console 
curl -L https://github.com/istio/istio/releases/download/1.0.5/istio-1.0.5-linux.tar.gz | tar xz
```
[add istioctl in the bin foder to your env]
```console 
export PATH=<istioctl_path>:$PATH
```

#### Istio operator
```console 
oc new-project istio-operator
oc new-app -f https://raw.githubusercontent.com/Maistra/openshift-ansible/maistra-0.4/istio/istio_community_operator_template.yaml --param=OPENSHIFT_ISTIO_MASTER_PUBLIC_URL="https://$(minishift ip):8443"
```

###### wait the operator to be ready
```console 
oc get pods -w -n istio-operator
```

#### Istio installation
```console 
scripts/istio/istio_installation.sh
```

###### wait the components to be ready
```console 
oc get pods -n istio-system
```
