#### Checks Topic
From the namespace where is installed strimzi (openshift-operators)
```console 
kubectl exec -it my-cluster-kafka-0 -c kafka -- bin/kafka-topics.sh --bootstrap-server my-cluster-kafka-bootstrap:9092 --list
```
It return in a empty cluster
```console 
_consumer_offsets
__strimzi-topic-operator-kstreams-topic-store-changelog
__strimzi_store_topic
```