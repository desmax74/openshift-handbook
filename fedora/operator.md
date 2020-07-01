### Operator
In the following command desmax is the namespace, replace with your

docker push quay.io/desmax74/kie-cloud-operator:<version>

#### Install operator courier
```console
pip3 install operator-courier
```

#### Verify
```console
operator-courier verify deploy/catalog_resources/community
```

#### Push on Quay
```console
operator-courier push deploy/catalog_resources/community desmax74 kiecloud-operator $(go run getversion.go) "basic xxxxxx="
```

#### Operator Source
```console
oc create -f - <<EOF
apiVersion: operators.coreos.com/v1
kind: OperatorSource
metadata:
  name: kiecloud-operators
  namespace: openshift-marketplace
spec:
  type: appregistry
  endpoint: https://quay.io/cnr
  registryNamespace: desmax74
  displayName: "KIE Cloud Operators"
  publisher: "Red Hat"
EOF
```

#### Catalog Source
```console
cat <<EOF | oc apply -f -
apiVersion: operators.coreos.com/v1
kind: CatalogSourceConfig
metadata:
 name: kiecloud-operators
 namespace: openshift-marketplace
spec:
 targetNamespace: openshift-operators"
 packages: kiecloud-operator
 source: upstream-community-operators
EOF
```

#### Operator Group
```console
cat <<EOF | oc apply -f -
apiVersion: operators.coreos.com/v1alpha2
kind: OperatorGroup
metadata:
 name: kiecloud-operator
 namespace: default
spec:
 targetNamespaces:
 - default
EOF
```

#### Subscription
```console
cat <<EOF | oc apply -f -
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
 name: kiecloud-operator
 namespace: default
spec:
 channel: stable
 installPlanApproval: Automatic
 name: kiecloud-operator
 source: upstream-community-operators
 sourceNamespace: default
EOF
```


#### Error message
ERROR:operatorcourier.push:{"error":{"code":"package-exists","details":{},"message":"package exists already"}}
solution:
```console
Quay.io > Applications -> Settings - Delete application
```
