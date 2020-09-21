### Sonatype Nexus 3:
Persistent
```console
oc new-project nexus
$ oc create -f https://raw.githubusercontent.com/monodot/openshift-nexus/master/nexus3-persistent-template.yaml
$ oc new-app nexus3-persistent NEXUS_VERSION=3.20.1
```

Ephemeral
```console
oc new-project nexus
$ oc create -f https://raw.githubusercontent.com/OpenShiftDemos/nexus/master/nexus3-template.yaml
$ oc new-app nexus3 -p NEXUS_VERSION=3.20.1
```


Nexus Outside openshift with self signed certificate

Keystore and cert
```console
keytool -genkeypair -keystore keystore.jks -storepass password -keypass password -alias jetty -keyalg RSA -keysize 2048 -validity 5000 -dname "CN=*.localhost, OU=Example, O=Sonatype, L=Unspecified, ST=Unspecified, C=US" -ext "SAN=DNS:localhost,IP:<ip>" -ext "BC=ca:true"
keytool -exportcert -keystore keystore.jks -alias jetty -rfc > jetty.cert
```

Docker secret
```console
docker swarm init
docker swarm join --token <token> <ip>:2377

docker secret create keystore /<path>/nexus-3.27.0-03/etc/ssl/keystore.jks

docker secret ls
```

Nexus vmoptions
 ```console
-Djavax.net.ssl.trustStore=/<path>/nexus-3.27.0-03/etc/ssl/keystore.jks
-Djavax.net.ssl.trustStoreType=jks
-Djavax.net.ssl.trustStorePassword=password
#-Djavax.net.ssl.keyStore=
#-Djavax.net.ssl.keyStorePassword=
```

Nexus default properties
 ```console
application-port-ssl=8443
nexus-args=${jetty.etc}/jetty.xml,${jetty.etc}/jetty-http.xml,${jetty.etc}/jetty-https.xml,${jetty.etc}/jetty-requestlog.xml
```

docker test

 ```console
docker run --env-file=/<path>/immutable.env --network host -v "/<path>/nexus-3.27.0-03/etc/ssl/"/target:/keys rhdm-7/rhdm-kieserver-rhel8:latest
```