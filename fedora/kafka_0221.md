Prerequisite Openshift 4.7.x
https://github.com/desmax74/openshift-handbook/blob/master/fedora/openshift.md

#### start crc 
```console
crc start --memory 10200 --cpus=4
```

#### Note:  We consider kafka watching a single namespace where is deployed, to watch multiple namespaces or all namespaces the configuration is different
#### log as a kubeadmin
```console 
oc login -u system:admin
eval $(minishift oc-env) 
eval $(minishift docker-env)
oc new-project my-kafka-project
```

#### Strimzi installation file
```console 
curl -L https://github.com/strimzi/strimzi-kafka-operator/releases/download/0.22.1/strimzi-cluster-operator-0.22.1.yaml \
 | sed 's/namespace: .*/namespace: my-kafka-project/' \
 | kubectl -n my-kafka-project apply -f -
```
 
#### Create the cluster ephemeral
```console 
kubectl apply -f scripts/kakfa/fedora/0.22.1/kafka-ephemeral.yaml -n my-kafka-project
```

#### Create the cluster persistent
```console 
kubectl apply -f scripts/kakfa/fedora/0.22.1/kafka-persistent-single.yaml -n my-kafka-project
```

#### Checks cluster status 
```console
kubectl get pods -n my-kafka-project -w
```

This create the cluster with auto create topics and the external routes to reach the brokers with tls authentication
#### create Topic
```console 
oc create -f scripts/kafka/fedora/events.yaml
oc create -f scripts/kafka/fedora/control.yaml
oc create -f scripts/kafka/fedora/snapshot.yaml
oc create -f scripts/kafka/fedora/kiesessioninfos.yaml
```
#### Delete Topic
```console 
oc exec -it my-cluster-kafka-0 -- bin/kafka-topics.sh --zookeeper localhost:2181 --delete --topic <topic_name>
```

#### Checks Topic
```console 
oc exec -it my-cluster-kafka-0 -- bin/kafka-topics.sh --zookeeper localhost:2181 --describe
```

#### Checks Topic's offset
```console 
oc exec -it my-cluster-kafka-0 -- bin/kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list localhost:9092 --topic <topic_name>
```
