Prerequisite Openshift 3.11
https://github.com/desmax74/openshift-handbook/blob/master/ubuntu/openshift.md

#### start openshift with kafka 
```console
sh scripts/kafka/ubuntu/minishift_start.sh 
```

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
```
#### Create the cluster
Wait the creation of all kafka and zookeeper pods before to run the command
```console 
oc create -f examples/kafka/kafka-ephemeral.yaml
```
This create the cluster with auto create topics and the external routes to reach the brokers with tls authentication
#### create Topic
```console 
oc create -f events.yaml
oc create -f control.yaml
oc create -f snapshot.yaml
```
#### Checks Topic
```console 
oc exec -it my-cluster-kafka-0 -- bin/kafka-topics.sh --zookeeper localhost:2181 --describe
```
#### Checks Topic's offset
```console 
oc exec -it my-cluster-kafka-0 -- bin/kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list localhost:9092 --topic events
```
