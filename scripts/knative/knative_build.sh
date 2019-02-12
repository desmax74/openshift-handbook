#!/usr/bin/env bash
# Setup Knative Build Policies
oc adm policy add-scc-to-user anyuid -z build-controller -n knative-build

# Install Knative Build components
oc apply --filename https://github.com/knative/build/releases/download/v0.3.0/release.yaml

# give cluster admin privileges to Service Account Build Controller on project knative-build
oc adm policy add-cluster-role-to-user cluster-admin -z build-controller -n knative-build