#!/bin/bash
oc project istio-operator
cat <<EOF >/tmp/istio-cr.yaml
apiVersion: "istio.openshift.com/v1alpha1"
kind: "Installation"
metadata:
  name: "istio-installation"
spec:
  deployment_type: origin
  istio:
    authentication: false
    community: true
    prefix: maistra/
    version: 0.4.0
  jaeger:
    prefix: jaegertracing/
    version: 1.7.0
    elasticsearch_memory: 2Gi
  kiali:
    username: admin
    password: admin
    prefix: kiali/
    version: v0.9.1
EOF
oc create -f /tmp/istio-cr.yaml