#### Installation ephemeral template
```console 
oc create -f scripts/infinispan/infinispan-ephemeral.yaml
```

##### Instantiate template and start cluster
```
oc new-app infinispan-ephemeral \
  -p APPLICATION_USER=test \
  -p APPLICATION_PASSWORD=<password> \
  -p NUMBER_OF_INSTANCES=3
```
 
##### Expose the service
 ```
oc expose svc/infinispan-app-http 
```

##### test store data
 ```
export ROUTE=`oc get route/infinispan-app-http -o jsonpath="{.spec.host}"`

 curl -v -u test:<password> \
   -H 'Content-type: text/plain' \
   -d 'test' \
   $ROUTE/rest/default/stuff
```

##### test read data
```
curl -v -u test:<password> $ROUTE/rest/default/stuff
```
##### cleanup
```
 oc delete all,secrets,sa,templates,configmaps,daemonsets,clusterroles,rolebindings,serviceaccounts --selector=template=infinispan-ephemeral || true
```

##### replace template with changes
```  
oc replace -f infinispan-ephemeral.yaml
```

##### remove template
```  
oc delete template infinispan-ephemeral
```  
    
#### Installation persistent template
```console 
oc create -f scripts/infinispan/infinispan-persistent.yaml
```
##### Relaxing permissions on persistent volumes
```console 
minishift ssh
sudo chmod -R a+w /var/lib/minishift/base/openshift.local.pv/pv*
sudo chmod -R 777 /var/lib/minishift/base/openshift.local.pv/pv*
exit
```

##### Instantiate the template
```console 
oc new-app infinispan-persistent \
  -p APPLICATION_USER=test \
  -p APPLICATION_PASSWORD=<password> \
  -p NUMBER_OF_INSTANCES=3
```
##### Expose endpoint
```console 
oc expose svc/infinispan-persistent-app-http
```

##### Store some data
```console 
export ROUTE=`oc get route/infinispan-persistent-app-http -o jsonpath="{.spec.host}"`
```
```console  
curl -v \
  -u test:<password> \
  -H 'Content-type: text/plain' \
  -d 'test' \
  $ROUTE/rest/default/stuff
```

#### Test the persistence simulating a restart with the number of replicas
```console 
oc scale statefulset infinispan-persistent-app --replicas=0
```
```console 
oc scale statefulset infinispan-persistent-app --replicas=3
```
##### Read the data
```console 
curl -v -u test:<password> $ROUTE/rest/default/stuff
```

##### cleanup
```
oc delete pvc -l application=infinispan-persistent-app
```