#### Note:  We consider kafka watching a single namespace where is deployed, to watch multiple namespaces or all namespaces the configuration is differente
#### log as a system
```console 
oc login -u system:admin
eval $(minishift oc-env) 
eval $(minishift docker-env)
oc new-project my-kafka-project
```

#### Deploy the Cluster Operator
```console 
sed -i 's/namespace: .*/namespace: my-kafka-project/' install/cluster-operator/*RoleBinding*.yaml
oc apply -f install/cluster-operator -n my-kafka-project
oc apply -f examples/templates/cluster-operator -n my-kafka-project

#### Create the cluster
```console 
oc create -f examples/kafka/kafka-ephemeral.yaml
```
#### create Topic
```console 
oc create -f master_events_topic.yaml
oc create -f users_input.yaml
```
#### Checks Topic
```console 
oc exec -it my-cluster-kafka-0 -- bin/kafka-topics.sh --zookeeper localhost:2181 --describe
```