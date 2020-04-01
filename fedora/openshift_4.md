#### CodeReady Containers 1.7.0 for Openshift 4.3.x
CodeReady Containers "CRC" is the replacement of minishift (Openshift 3.x) for Openshift version 4
A Red Hat account is required in order to access the user pull secret.
You must have a redhat account to install openshift 4 on your local machine.
If you have already one, login with your account with the next section;

 
#### Create an account on cloud.redhat.com

https://cloud.redhat.com/openshift/install
and download or copy your Pull secret from the the laptop
installation https://cloud.redhat.com/openshift/install/crc/installer-provisioned

To avoid no such host error
```console 
sudo nano /etc/hosts 
```
add (example to use 192.168.130.11)
```console 
192.168.130.11   api.crc.testing
192.168.130.11   foo.apps-crc.testing
192.168.130.11   oauth-openshift.apps-crc.testing
192.168.130.11   console-openshift-console.apps-crc.testing
192.168.130.11   my-cluster-kafka-bootstrap-my-kafka-project.apps-crc.testing
192.168.130.11   my-cluster-kafka-0-my-kafka-project.apps-crc.testing
192.168.130.11   my-cluster-kafka-1-my-kafka-project.apps-crc.testing
192.168.130.11   my-cluster-kafka-2-my-kafka-project.apps-crc.testing
```
Reboot the system to avoid permission denied on libvirt

#### Download latest CRC
```console 
wget https://mirror.openshift.com/pub/openshift-v4/clients/crc/latest/crc-linux-amd64.tar.xz
tar -xvf crc-linux-amd64.tar.xz
```

At the time os this tutorial the version is 1.7.0, change accordingly with the updated version downloaded

```console 
cd crc-linux-1.7.0-amd64
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

With AMQ Stream/Strimzi cluster is better use 16gb 
```console 
crc start config set memory 16384 
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

or from the file 
```console
~/.crc/cache/crc_libvirt_4.3.1/kubeadmin-password
```

#### Open Web Console
```console 
crc console
```

#### Stop cluster
```console 
crc stop
```

#### Delete vm
```console 
crc delete
```

#### Configure ram and cpu
Edit file in  "/home/<user>/.crc/machines/crc/config.json"
```console 
{
    "ConfigVersion": 3,
    "Driver": {
        "IPAddress": "192.168.130.11",
        "MachineName": "crc",
        "SSHUser": "core",
        "SSHPort": 0,
        "StorePath": "/home/<user>/.crc",
        "BundleName": "crc_libvirt_4.3.1.crcbundle",
        "SSHKeyPath": "/home/<user>/.crc/cache/crc_libvirt_4.3.1/id_rsa_crc",
        "Memory": 16384,
        "CPU": 4,
        "Network": "crc",
        "DiskPath": "/home/<user>/.crc/machines/crc/crc",
        "DiskPathURL": "file:///home/<user>/.crc/cache/crc_libvirt_4.3.1/crc.qcow2",
        "CacheMode": "default",
        "IOMode": "threads",
        "VM": {}
    },
    ....
```

#### CRC version
```console
[max@localhost]$ crc version
crc version: 1.7.0+fa7e558
OpenShift version: 4.3.1 (embedded in binary)
```

#### CRC status
```console
[max@localhost]$ crc status
CRC VM:          Running
OpenShift:       Running (v4.3.1)
Disk Usage:      9.783GB of 32.2GB (Inside the CRC VM)
Cache Usage:     25.48GB
Cache Directory: /home/<user>/.crc/cache
```
