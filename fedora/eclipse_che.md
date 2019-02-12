### IDE
[You could choose a plain Eclipse Che or CodeReady, not together]
#### Eclipse CHE 6 (single user)
```console 
minishift addons enable che && minishift addons apply che
minishift addons apply --addon-env CHE_DOCKER_IMAGE=eclipse/che-server:local che
```

[the address could find in the webconsole->application->routes, usually is http://che-mini-che.{ip}.nip.io/dashboard/]
