#### Notes about Openshift, Istio, Eclipse Che 6 on Fedora 29





#### Virtualbox
https://download.virtualbox.org/virtualbox/6.0.4/VirtualBox-6.0-6.0.4_128413_fedora29-1.x86_64.rpm
https://download.virtualbox.org/virtualbox/6.0.4/Oracle_VM_VirtualBox_Extension_Pack-6.0.4.vbox-extpack

[could require the installation of the kernel's header ]

```console 
sudo /usr/lib/virtualbox/vboxdrv.sh setup
```

#### Docker 
```console 
sudo dnf install -y docker
```

#### Minishift
```console
wget https://github.com/minishift/minishift/releases/download/v1.31.0/minishift-1.31.0-linux-amd64.tgz
```

[add to your env ] 
```console 
export PATH=<minishift_path>:$PATH
```

#### Openshift client
```console 
wget https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
```
[add to your env]
```console 
export PATH=<openshift_client_path>:$PATH
```

#### Kubectl
```console 
dnf install -y kubernetes-client
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
./scripts/mesh_installation.sh
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

#### Istio
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
./scripts/istio_installation.sh
```

###### wait the componet to be ready
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
minishift addons enable che && minishift addons apply chem
minishift addons apply --addon-env CHE_DOCKER_IMAGE=eclipse/che-server:local che
```

[the address could find in the webconsole->application->routes, usually is http://che-mini-che.{ip}.nip.io/dashboard/]


### Optional tools

#### Siege for load testing
```console 
sudo dnf install -y siege
```

#### Stern for logs
```console 
sudo curl --output /usr/local/bin/stern -L https://github.com/wercker/stern/releases/download/1.6.0/stern_linux_amd64 && sudo chmod +x /usr/local/bin/stern
```
#### Buildah
```console 
sudo yum -y install buildah
```

#### Podman
```console 
sudo dnf install -y podman

sudo dnf install -y git runc libassuan-devel golang golang-github-cpuguy83-go-md2man glibc-static \
                                  gpgme-devel glib2-devel device-mapper-devel libseccomp-devel \
                                  atomic-registries iptables skopeo-containers containernetworking-cni \
                                  conmon ostree-devel

curl -L https://dl.google.com/go/go1.11.5.linux-amd64.tar.gz --output go.tar.gz | tar xz
```
```console 
export GOPATH=./go
mkdir -p $GOPATH
git clone https://github.com/containers/libpod/ $GOPATH/src/github.com/containers/libpod
cd $GOPATH/src/github.com/containers/libpod
make
sudo make install PREFIX=/usr
