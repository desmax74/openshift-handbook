
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
wget https://github.com/minishift/minishift/releases/download/v1.34.0/minishift-1.34.0-linux-amd64.tgz
```

[add to your env ] 
```console 
export PATH=<minishift_path>:$PATH
```

#### Openshift client (oc and kubectl)
##### you could skip since oc is delivered with openshift startup
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
./scripts/minishift/ubuntu/minishift_start.sh
```

##### Setup minishift
```console 
eval $(minishift oc-env) 
eval $(minishift docker-env)
oc login $(minishift ip):8443 -u admin -p admin
```
