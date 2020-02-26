#### Prerequisites Kogito Go env
https://github.com/kiegroup/kogito-cloud-operator/blob/master/docs/CONTRIBUTING.MD


#### Build CLI
```console
cd ${user_home}/go/src/kogito-cloud-operator/cmd/kogito/

go build

chmod +x kogito

./kogito
```

#### Build Operator
```console
cd ${user_home}/go/src/kogito-cloud-operator/cmd/manager/

go build

chmod +x manager
```
