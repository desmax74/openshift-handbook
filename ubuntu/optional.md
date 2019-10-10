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

######
```console 
sudo apt-get update -qq
sudo apt-get install -qq -y software-properties-common uidmap
sudo add-apt-repository -y ppa:projectatomic/ppa
sudo apt-get update -qq
sudo apt-get -qq -y install podman
```

#### Skopeo 
CLI to works with on container images and image repositories 
```console 

```