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
###### you could skip since kubectl is delivered with oc
```console 
dnf install -y kubernetes-client
```

#### Start minishift 
[reviews amount of ram and cpu (by default are 8gb and 3 cpu)]
```console 
scripts/minishift_start.sh
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


