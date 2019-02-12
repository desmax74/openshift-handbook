#!/usr/bin/env bash
minishift profile set knative-tutorial
minishift config set memory 10GB
minishift config set cpus 4
minishift config set vm-driver virtualbox
minishift config set image-caching true
minishift config set openshift-version v3.11.0
minishift config set disk-size 50g
minishift addons enable admin-user
minishift addon enable anyuid
minishift start

#eval $(minishift docker-env) && eval $(minishift oc-env)