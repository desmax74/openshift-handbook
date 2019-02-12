#!/usr/bin/env bash
# Setup Knative Eventing Policies
oc adm policy add-scc-to-user anyuid -z eventing-controller -n knative-eventing
oc adm policy add-scc-to-user anyuid -z in-memory-channel-dispatcher -n knative-eventing
oc adm policy add-scc-to-user anyuid -z in-memory-channel-controller -n knative-eventing

# Install Knative Eventing components
oc apply --filename https://github.com/knative/eventing/releases/download/v0.3.0/release.yaml
oc apply --filename https://github.com/knative/eventing-sources/releases/download/v0.3.0/release.yaml

# give cluster admin privileges to Service Accounts on project knative-eventing
oc adm policy add-cluster-role-to-user cluster-admin -z eventing-controller -n knative-eventing
oc adm policy add-cluster-role-to-user cluster-admin -z default -n knative-sources
oc adm policy add-cluster-role-to-user cluster-admin -z in-memory-channel-dispatcher -n knative-eventing
oc adm policy add-cluster-role-to-user cluster-admin -z in-memory-channel-controller -n knative-eventing