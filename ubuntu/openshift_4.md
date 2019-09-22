#### CodeReady Containers
CodeReady Containers "CRC" is the replacement of minishift (Openshift 3.x) for Openshift version 4
A Red Hat account is required in order to access the user pull secret.
You must have a redhat account to install openshift 4 on your local machine.
If you have already one, login with your account with the next section;

 
#### Create an account on cloud.redhat.com

https://cloud.redhat.com/openshift/install
and download or copy your Pull secret from the the laptop
installation https://cloud.redhat.com/openshift/install/crc/installer-provisioned

#### Install libvirt libs
```console 
sudo apt install qemu-kvm libvirt-daemon libvirt-daemon-system network-manager
```

To avoid no such host error
```console 
sudo nano /etc/hosts 
```
add 
```console 
192.168.130.11   api.crc.testing
192.168.130.11   oauth-openshift.apps-crc.testing
192.168.130.11   console-openshift-console.apps-crc.testing
```
Reboot the system to avoid permission denied on libvirt

#### Download latest CRC
```console 
wget https://mirror.openshift.com/pub/openshift-v4/clients/crc/latest/crc-linux-amd64.tar.xz
tar -xvf crc-linux-amd64.tar.xz
```

At the time os this tutorial the version is 1.0.0-beta.5, change accordingly with the updated version downloaded 

```console 
cd crc-linux-1.0.0-beta.5-amd64
export PATH=$PATH:$(pwd)
```

#### Pre Setup
```console 
sudo usermod -aG libvirtd $(whoami)
newgrp libvirtd
crc config set skip-check-user-in-libvirt-group true
```

#### Setup
```console 
crc setup
```


```console 
crc start
 ```
 When prompted to image pull secret, paste your pull secret that you copied in the previous step (https://cloud.redhat.com/openshift/install/crc/installer-provisioned)
 and press enter

```console 
 crc oc-env
 ```
 It shows 
```console 
export PATH="/home/<user>/.crc/bin:$PATH"
# Run this command to configure your shell:
# eval $(crc oc-env)
```

#### Checks the cluster status
```console 
oc get co
```

#### Login from cli
```console 
'oc login -u kubeadmin -p <XXXXX-XXXX-XXXXX-XXXXX> https://api.crc.testing:6443'
```
The kubeadmin password could be retrieved from the start output

```console
INFO To access the cluster, first set up your environment by following 'crc oc-env' instructions 
INFO Then you can access it by running 'oc login -u developer -p developer https://api.crc.testing:6443' 
INFO To login as an admin, username is 'kubeadmin' and password is <XXXXX-XXXX-XXXXX-XXXXX> 
INFO                                              
INFO These credentials can also be used to access the OpenShift web console at https://console-openshift-console.apps-crc.testing 
```

#### Open Console
```console 
crc console
```



