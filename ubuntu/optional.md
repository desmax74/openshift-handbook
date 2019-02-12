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