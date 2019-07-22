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

#### Strimzi installation file
```console 
curl -L https://github.com/strimzi/strimzi-kafka-operator/releases/download/0.12.2/strimzi-cluster-operator-0.12.2.yaml \
 | sed 's/namespace: .*/namespace: my-kafka-project/' \
 | kubectl -n my-kafka-project apply -f -
```
 
#### Create the cluster ephemeral
```console 
kubectl apply -f https://raw.githubusercontent.com/strimzi/strimzi-kafka-operator/0.12.2/examples/kafka/kafka-ephemeral.yaml -n my-kafka-project
```

#### Create the cluster persistent
```console 
kubectl apply -f https://raw.githubusercontent.com/strimzi/strimzi-kafka-operator/0.12.2/examples/kafka/kafka-persistent-single.yaml -n my-kafka-project
```

#### Checks cluster status 
```console
kubectl get pods -n kafka -w
```

This create the cluster with auto create topics and the external routes to reach the brokers with tls authentication
#### create Topic
```console 
oc create -f scripts/kafka/ubuntu/events.yaml
oc create -f scripts/kafka/ubuntu/control.yaml
oc create -f scripts/kafka/ubuntu/snapshot.yaml
oc create -f scripts/kafka/ubuntu/kiesessioninfos.yaml
```
#### Checks Topic
```console 
oc exec -it my-cluster-kafka-0 -- bin/kafka-topics.sh --zookeeper localhost:2181 --describe
```
#### Checks Topic's offset
```console 
oc exec -it my-cluster-kafka-0 -- bin/kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list localhost:9092 --topic events
```
