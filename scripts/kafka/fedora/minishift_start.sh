#!/bin/bash

# add the location of minishift executable to PATH
# I also keep other handy tools like kubectl and kubetail.sh
# in that directory

minishift profile set kafka
minishift config set memory 8192
minishift config set cpus 2
minishift config set vm-driver kvm

minishift config set openshift-version v3.11.0
minishift addon enable admin-user
minishift addon disable anyuid
minishift start
