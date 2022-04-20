#### Prerequisite: 
Opm
```console
https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest/
```
Podman
```console
https://podman.io/
```

Cekit
```console
https://github.com/cekit/cekit
```

A Quay.io account.
```console
https://quay.io/
```

remove the following line from deploy/olm-catalog/dev/<last-version>/manifest/businessautomation-operator.clusterserviceversion.yaml 
```console
replaces: businessautomation-operator.<last-version>
```

#### Build the bundle
Activate Cekit and run the following command
```console
$ make bundle-dev
```

the last log line is something like this:
```console
INFO  Image built and available under following tags: quay.io/${USERNAME}/rhpam-operator-bundle:7.12.1, quay.io/${USERNAME}/rhpam-operator-bundle:latest
```
Push the bundle on the container registry 
VERSION=$(go run getversion.go)
USERNAME=<your_quay_id>
```console
$ docker push quay.io/${USERNAME}/rhpam-operator-bundle:${VERSION}
```

#### Build the indec
```console
opm index add --bundles quay.io/${USERNAME}/rhpam-operator-bundle:${VERSION} --tag quay.io/${USERNAME}/rhpam-operator--index:${VERSION} --permissive
```
#### Push the index on the container registry
Podman images
```console
podman push quay.io/${USERNAME}/rhpam-operator--index:${VERSION}
```

#### Disable default catalog sources on Openshift
To test your Operator, with bundle and index you need to disable the default source like the operator hub
```console
oc patch OperatorHub cluster --type json -p '[{"op": "add", "path": "/spec/disableAllDefaultSources", "value": true}]'
```

#### catalog-source.yaml
```console
apiVersion: operators.coreos.com/v1alpha1
kind: CatalogSource
metadata:
  name: xxxxxname
  namespace: openshift-marketplace
spec:
  sourceType: grpc
  image: xxxxximage
  displayName: My Operator Catalog
  publisher: grpc
```

Choose a CATALOG_SOURCE_NAME something like "max-operator-manifests"

```console
sed -i "s/xxxxxname/$CATALOG_SOURCE_NAME/" catalog-source.yaml
```
```console
sed -i "s/xxxxximage/$(echo $INDEXING_IMAGE | sed "s.\/.\\\/.g")/" catalog-source.yaml
```

Example of catalog-source
```console
apiVersion: operators.coreos.com/v1alpha1
kind: CatalogSource
metadata:
  name: max-operator-manifests
  namespace: openshift-marketplace
spec:
  sourceType: grpc
  image: quay.io/<your_quay_id>/rhpam-operator--index:7.12.1
  displayName: My Operator Catalog
  publisher: grpc
```

#### Create catalog source on Openshift
```console
oc create -f catalog-source.yaml
```

#### subscription.yaml
```console
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: businessautomation-operator
  namespace: <your-namespace>
spec:
  channel: stable
  name: businessautomation-operator
  source: $CATALOG_SOURCE_NAME
  sourceNamespace: openshift-marketplace
```


```console
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: businessautomation-operator
  namespace: max
spec:
  channel: stable
  name: businessautomation-operator
  source: max-operator-manifests
  sourceNamespace: openshift-marketplace
```

#### Create subscription
```console
oc create -f subscription.yaml
```
On Openshift go to project "openshift-marketplace" to see your subscription and your operator, 
this could take a variable time to be visible.


#### Cleanup catalog-source
After your test are completed, to restore the Operator hub and remove your catalog source 
delete your catalog source
and run the following command:
```console
oc patch OperatorHub cluster --type json -p '[{"op": "add", "path": "/spec/disableAllDefaultSources", "value": false}]'
```


