#!/usr/bin/env bash
oc apply -n istio-system -f ./istio-sidecar-injector.yaml
