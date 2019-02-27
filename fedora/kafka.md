#### Note:  We consider kafka watching a single namespace where is deployed, to watch multiple namespaces or all namespaces the configuration is differente
#### log as a system
```console 
eval $(minishift oc-env) 
eval $(minishift docker-env)
oc login -u system:admin
```

oc new-project my-kafka-project
#### Choose the name of the namespace to deploy
```console 
cd scripts/kafka/fedora/
sed -i 's/namespace: .*/namespace: <namespace>/' cluster-operator/*RoleBinding*.yaml
```
#### Deploy the Cluster Operator
```console 
oc apply -f cluster-operator -n <namespace>
oc apply -f templates/cluster-operator -n <namespace>
```


```console 
oc new-project my-kafka-project
oc apply -f cluster-operator/020-RoleBinding-strimzi-cluster-operator.yaml -n my-kafka-project
oc apply -f cluster-operator/032-RoleBinding-strimzi-cluster-operator-topic-operator-delegation.yaml -n my-kafka-project
oc apply -f cluster-operator/031-RoleBinding-strimzi-cluster-operator-entity-operator-delegation.yaml -n my-kafka-project

#### Create my-cluster
```console 
oc create -f my_cluster.yaml
```
#### create Topic
```console 
oc create -f my_topic.yaml
```
