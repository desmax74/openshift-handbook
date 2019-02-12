#!/usr/bin/env bash
minishift openshift config set --target=kube --patch '{
  "admissionConfig": {
    "pluginConfig": {
      "ValidatingAdmissionWebhook": {
        "configuration": {
          "apiVersion": "apiserver.config.k8s.io/v1alpha1",
          "kind": "WebhookAdmission",
          "kubeConfigFile": "/dev/null"
        }
      },
      "MutatingAdmissionWebhook": {
        "configuration": {
          "apiVersion": "apiserver.config.k8s.io/v1alpha1",
          "kind": "WebhookAdmission",
          "kubeConfigFile": "/dev/null"
        }
      }
    }
  }
}'

# Allowing few minutes for the OpenShift to be restarted
until oc login -u admin -p admin 2>/dev/null; do sleep 5; done;