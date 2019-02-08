#### Notes about Openshift, Istio, Eclipse Che 6 on Ubuntu 18.10


#### Virtualbox
https://download.virtualbox.org/virtualbox/6.0.4/virtualbox-6.0_6.0.4-128413~Ubuntu~bionic_amd64.deb
https://download.virtualbox.org/virtualbox/6.0.4/Oracle_VM_VirtualBox_Extension_Pack-6.0.4.vbox-extpack

[could require the installation of the kernel's header ]

```console 
sudo /usr/lib/virtualbox/vboxdrv.sh setup
```

#### Docker 
```console 
sudo apt-get install -y docker
```

#### Minishift
```consolefedora29fedora29
wget https://github.com/minishift/minishift/releases/download/v1.31.0/minishift-1.31.0-linux-amd64.tgz
```

[add to your env ] 
```console 
export PATH=<minishift_path>:$PATH
```

#### Openshift client (oc and kubectl)
```console 
wget https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
```
[add to your env]
```console 
export PATH=<openshift_client_path>:$PATH
```

#### Kubectl
##### you could skip since kubectl is delivered with oc
```console 
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
```

#### Start minishift 
[reviews amount of ram and cpu (by default are 8gb and 3 cpu)]
```console 
./scripts/minishift_start.sh
```

##### Setup minishift
```console 
eval $(minishift oc-env) 
eval $(minishift docker-env)
oc login $(minishift ip):8443 -u admin -p admin
```

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

### IDE
[You could choose a plain Eclipse Che or CodeReady, not together]
#### Istio installation
```console 
scripts/istio_installation.sh
```

###### wait the components to be ready
```console 
oc get pods -n istio-system
```


### Openshift console
[the address is at the end of the log of the minishift, otherwise]
```console 
minishift console
```


#### Eclipse CHE
```console 
minishift addons enable che && minishift addons apply che
minishift addons apply --addon-env CHE_DOCKER_IMAGE=eclipse/che-server:local che
```
#### CodeReady
```console 
scripts/deploy_codeready.sh  --deploy
```

[the address could find in the webconsole->application->routes, usually is http://che-mini-che.{ip}.nip.io/dashboard/]


### Optional tools

#### Siege for load testing
```console 
sudo apt-get install -y siege
```

#### Stern for logs
```console 
sudo curl --output /usr/local/bin/stern -L https://github.com/wercker/stern/releases/download/1.6.0/stern_linux_amd64 && sudo chmod +x /usr/local/bin/stern
```
#### Buildah
```console 
sudo apt-get update -qq
sudo apt-get install -qq -y software-properties-common
sudo add-apt-repository -y ppa:projectatomic/ppa
sudo apt-get -qq -y install buildah
```

#### Podman

###### Common packages
```console 
sudo apt-get update
sudo apt-get install libdevmapper-dev libglib2.0-dev libgpgme11-dev golang libseccomp-dev libostree-dev \
                        go-md2man libprotobuf-dev libprotobuf-c0-dev libseccomp-dev python3-setuptools
```

###### Install Golang
```console 
cd
curl -L https://dl.google.com/go/go1.11.5.linux-amd64.tar.gz --output go.tar.gz | tar xz
```

###### Build and install conmon
```console 
export GOPATH=~/go
mkdir -p $GOPATH
git clone https://github.com/kubernetes-sigs/cri-o $GOPATH/src/github.com/kubernetes-sigs/cri-o
cd $GOPATH/src/github.com/kubernetes-sigs/cri-o
mkdir bin
make bin/conmon
sudo install -D -m 755 bin/conmon /usr/libexec/podman/conmon
```
###### Adding required configuration files
```console 
sudo mkdir -p /etc/containers
sudo curl https://raw.githubusercontent.com/projectatomic/registries/master/registries.fedora -o /etc/containers/registries.conf
sudo curl https://raw.githubusercontent.com/containers/skopeo/master/default-policy.json -o /etc/containers/policy.json
```
###### Installing CNI plugins
```console 
git clone https://github.com/containernetworking/plugins.git $GOPATH/src/github.com/containernetworking/plugins
cd $GOPATH/src/github.com/containernetworking/plugins
./build_linux.sh
sudo mkdir -p /usr/libexec/cni
sudo cp bin/* /usr/libexec/cni
```

###### Installing runc
```console 
git clone https://github.com/opencontainers/runc.git $GOPATH/src/github.com/opencontainers/runc
cd $GOPATH/src/github.com/opencontainers/runc
make BUILDTAGS="seccomp"
sudo cp runc /usr/bin/runc
```
###### Build and install podman
```console 
git clone https://github.com/containers/libpod/ $GOPATH/src/github.com/containers/libpod
cd $GOPATH/src/github.com/containers/libpod
make
sudo make install PREFIX=/usr
```

#### Skopeo 
CLI to works with on container images and image repositories 
```console 

```