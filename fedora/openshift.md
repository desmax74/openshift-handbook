#### kvm
```console 
sudo dnf install libvirt qemu-kvm
sudo usermod -a -G libvirt $(whoami)
newgrp libvirt
sudo curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.10.0/docker-machine-driver-kvm-centos7 -o /usr/local/bin/docker-machine-driver-kvm
sudo chmod +x /usr/local/bin/docker-machine-driver-kvm
```

#### Docker 
```console 
sudo dnf install -y docker
```

#### Minishift
```console
wget https://github.com/minishift/minishift/releases/download/v1.34.0/minishift-1.34.0-linux-amd64.tgz
```

[add to your env ] 
```console 
export PATH=<minishift_path>:$PATH
```

#### Openshift client
##### you could skip since oc is delivered with openshift startup
```console 
wget https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
```
[add to your env]
```console 
export PATH=<openshift_client_path>:$PATH
```

#### Kubectl
###### you could skip since kubectl is delivered with oc
```console 
dnf install -y kubernetes-client
```

#### Start minishift 
[reviews amount of ram and cpu (by default are 8gb and 3 cpu)]
```console 
scripts/minishift/fedora/minishift_start.sh
```

##### Setup minishift
```console 
eval $(minishift oc-env) 
eval $(minishift docker-env)
oc login $(minishift ip):8443 -u admin -p admin
```


### Openshift console
[the address is at the end of the log of the minishift, otherwise]
```console 
minishift console
```


