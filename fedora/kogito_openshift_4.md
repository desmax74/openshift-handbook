####Start crc with 16gb

crc start config set memory 16384
```console
crc start config set memory 16384
```

#### Install operator Openshift 4.3.x
In the section Operators->OperatorHub choose Kogito Operator and then install,  
four operator wil be installed:
Kogito-operator, Infinispan-operator, keycloak-operator, strimzi-operator


#### Create you project
```console
oc new-project my-project
```

Kogito use your project
```console
kogito use-project my-project
```

#### Create app
```console
./kogito deploy-service example-quarkus https://github.com/kiegroup/kogito-examples/ --context-dir=drools-quarkus-example
```

####logs
```console
oc logs -f bc/example-quarkus-builder -n my-kafka-project
```


### add to /etc/hosts
```console
sudo nano /etc/hosts 
192.168.130.11   example-quarkus-my-kafka-project.apps-crc.testing
```