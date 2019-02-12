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
```
###### Install Golang
```console 
cd
curl -L https://dl.google.com/go/go1.11.5.linux-amd64.tar.gz --output go.tar.gz | tar xz
```
```console 
export GOPATH=./go
mkdir -p $GOPATH
git clone https://github.com/containers/libpod/ $GOPATH/src/github.com/containers/libpod
cd $GOPATH/src/github.com/containers/libpod
make
sudo make install PREFIX=/usr
```

#### Skopeo 
CLI to works with on container images and image repositories 
```console 
sudo dnf install -y skopeo
```