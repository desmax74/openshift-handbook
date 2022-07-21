#### Prerequisite: 

### kubectl 

download binary, sha, check and then install in the path
```console
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

###API Objects
```console
kubectl get --raw /
```
formatted 
```console
kubectl get --raw /api/v1/ | python -m json.tool
```


