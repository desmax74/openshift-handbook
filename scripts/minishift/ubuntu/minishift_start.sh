#!/bin/bash

# add the location of minishift executable to PATH
# I also keep other handy tools like kubectl and kubetail.sh
# in that directory

minishift profile set tutorial
minishift config set memory 10GB
minishift config set cpus 4
minishift config set vm-driver virtualbox
minishift config set image-caching true
minishift config set openshift-version v3.11.0
minishift addon enable admin-user
minishift addon enable anyuid

minishift start
minishift ssh -- sudo setenforce 0