#!/usr/bin/env bash
# Setup Knative Serving Policies
oc adm policy add-scc-to-user anyuid -z controller -n knative-serving
oc adm policy add-scc-to-user anyuid -z autoscaler -n knative-serving

# Install Knative Serving components
curl -L https://github.com/knative/serving/releases/download/v0.3.0/serving.yaml | sed 's/LoadBalancer/NodePort/' | kubectl apply --filename -

# give cluster admin privileges to Service Account Controller on project knative-serving
oc adm policy add-cluster-role-to-user cluster-admin -z controller -n knative-serving