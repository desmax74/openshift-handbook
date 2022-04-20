### Script configured in the yaml

in module.yaml https://github.com/desmax74/jboss-kie-modules/blob/master/jboss-kie-kieserver/module.yaml 
a configure.sh is called

https://github.com/desmax74/jboss-kie-modules/blob/master/jboss-kie-kieserver/configure.sh 



in the yaml instead
like https://github.com/desmax74/jboss-kie-modules/blob/master/jboss-kie-kieserver/added/launch/jboss-kie-kieserver-hooks.sh

or
https://github.com/desmax74/jboss-kie-modules/blob/master/jboss-kie-kieserver/added/openshift-launch.sh
into /opt/eap/bin/openshift-launch.sh

but the values suggest the jvm are set at the end by
https://github.com/jboss-openshift/cct_module/blob/master/jboss/container/java/jvm/bash/artifacts/opt/jboss/container/java/jvm/java-default-options
because run with https://github.com/desmax74/jboss-kie-modules/blob/master/jboss-kie-kieserver/added/launch/kieserver-install.sh#L21
```console
kind: Pod
apiVersion: v1
metadata:
  generateName: rhpam-production-kieserver-1-
  annotations:
    k8s.v1.cni.cncf.io/networks-status: |-
      [{
          "name": "openshift-sdn",
          "interface": "eth0",
          "ips": [
              "10.130.2.76"
          ],
          "dns": {},
          "default-route": [
              "10.130.2.1"
          ]
      }]
    openshift.io/deployment-config.latest-version: '1'
    openshift.io/deployment-config.name: rhpam-production-kieserver
    openshift.io/deployment.name: rhpam-production-kieserver-1
    openshift.io/scc: restricted
  selfLink: /api/v1/namespaces/max/pods/rhpam-production-kieserver-1-vwn2z
  resourceVersion: '7691319'
  name: rhpam-production-kieserver-1-vwn2z
  uid: 24e77763-5e2e-4aeb-ba14-b59953e73eba
  creationTimestamp: '2020-07-13T18:06:54Z'
  namespace: max
  ownerReferences:
    - apiVersion: v1
      kind: ReplicationController
      name: rhpam-production-kieserver-1
      uid: 22afc2a4-fd9a-47e5-a419-8f94d8a6bf61
      controller: true
      blockOwnerDeletion: true
  labels:
    app: rhpam-production
    application: rhpam-production
    deployment: rhpam-production-kieserver-1
    deploymentConfig: rhpam-production-kieserver
    deploymentconfig: rhpam-production-kieserver
    service: rhpam-production-kieserver
    services.server.kie.org/kie-server-id: rhpam-production-kieserver
spec:
  restartPolicy: Always
  initContainers:
    - resources: {}
      terminationMessagePath: /dev/termination-log
      name: rhpam-production-kieserver-postgresql-init
      command:
        - /bin/bash
        - '-c'
        - >-
          >- replicas=$(oc get dc rhpam-production-kieserver-postgresql
          -o=jsonpath='{.status.availableReplicas}'); until '[' $replicas -gt 0
          ']'; do echo waiting for rhpam-production-kieserver-postgresql;
          replicas=$(oc get dc rhpam-production-kieserver-postgresql
          -o=jsonpath='{.status.availableReplicas}'); sleep 2; done;
      securityContext:
        capabilities:
          drop:
            - KILL
            - MKNOD
            - SETGID
            - SETUID
        runAsUser: 1013390000
      imagePullPolicy: IfNotPresent
      volumeMounts:
        - name: rhpam-production-rhpamsvc-token-z7r2h
          readOnly: true
          mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      terminationMessagePolicy: FallbackToLogsOnError
      image: >-
        registry.redhat.io/openshift3/ose-cli@sha256:eda798d5c0f026b2221716f5df33fd97cd25bfb565f969e76e62815f1bd3a924
  serviceAccountName: rhpam-production-rhpamsvc
  imagePullSecrets:
    - name: rhpam-production-rhpamsvc-dockercfg-tzzzc
  priority: 0
  schedulerName: default-scheduler
  enableServiceLinks: true
  terminationGracePeriodSeconds: 90
  nodeName: playground-ps2p6-worker-cc62l
  securityContext:
    seLinuxOptions:
      level: 's0:c116,c25'
    fsGroup: 1013390000
  containers:
    - resources:
        limits:
          memory: 1Gi
        requests:
          memory: 1Gi
      readinessProbe:
        httpGet:
          path: /services/rest/server/readycheck
          port: 8080
          scheme: HTTP
        initialDelaySeconds: 30
        timeoutSeconds: 2
        periodSeconds: 5
        successThreshold: 1
        failureThreshold: 36
      terminationMessagePath: /dev/termination-log
      lifecycle:
        postStart:
          exec:
            command:
              - /bin/sh
              - /opt/eap/bin/launch/jboss-kie-kieserver-hooks.sh
        preStop:
          exec:
            command:
              - /bin/sh
              - /opt/eap/bin/launch/jboss-kie-kieserver-hooks.sh
      name: rhpam-production-kieserver
      livenessProbe:
        httpGet:
          path: /services/rest/server/healthcheck
          port: 8080
          scheme: HTTP
        initialDelaySeconds: 180
        timeoutSeconds: 2
        periodSeconds: 15
        successThreshold: 1
        failureThreshold: 3
      env:
        - name: WORKBENCH_SERVICE_NAME
          value: rhpam-production-rhpamcentrmon
        - name: KIE_ADMIN_USER
          value: adminUser
        - name: KIE_ADMIN_PWD
          value: s92IIH9u
        - name: KIE_SERVER_STARTUP_STRATEGY
          value: OpenShiftStartupStrategy
        - name: DROOLS_SERVER_FILTER_CLASSES
          value: 'true'
        - name: KIE_SERVER_CONTROLLER_SERVICE
          value: rhpam-production-rhpamcentrmon
        - name: KIE_SERVER_CONTROLLER_PROTOCOL
          value: ws
        - name: KIE_SERVER_MODE
          value: PRODUCTION
        - name: KIE_MBEANS
          value: enabled
        - name: KIE_SERVER_HOST
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: status.podIP
        - name: KIE_SERVER_ID
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: 'metadata.labels[''services.server.kie.org/kie-server-id'']'
        - name: KIE_SERVER_ROUTE_NAME
          value: rhpam-production-kieserver
        - name: RHPAMCENTR_MAVEN_REPO_USERNAME
          value: adminUser
        - name: RHPAMCENTR_MAVEN_REPO_PASSWORD
          value: s92IIH9u
        - name: RHPAMCENTR_MAVEN_REPO_SERVICE
          value: rhpam-production-rhpamcentrmon
        - name: MAVEN_REPOS
          value: 'RHPAMCENTR,EXTERNAL'
        - name: RHPAMCENTR_MAVEN_REPO_PATH
          value: /maven2/
        - name: KIE_SERVER_BYPASS_AUTH_USER
          value: 'false'
        - name: HTTPS_KEYSTORE_DIR
          value: /etc/kieserver-secret-volume
        - name: HTTPS_KEYSTORE
          value: keystore.jks
        - name: HTTPS_NAME
          value: jboss
        - name: HTTPS_PASSWORD
          value: pw8249M8
        - name: JGROUPS_PING_PROTOCOL
          value: openshift.DNS_PING
        - name: OPENSHIFT_DNS_PING_SERVICE_NAME
          value: rhpam-production-kieserver-ping
        - name: OPENSHIFT_DNS_PING_SERVICE_PORT
          value: '8888'
        - name: EXTERNAL_MAVEN_REPO_ID
        - name: EXTERNAL_MAVEN_REPO_URL
        - name: EXTERNAL_MAVEN_REPO_USERNAME
        - name: EXTERNAL_MAVEN_REPO_PASSWORD
        - name: DATASOURCES
          value: RHPAM
        - name: RHPAM_DATABASE
          value: rhpam7
        - name: RHPAM_JNDI
          value: 'java:/jboss/datasources/rhpam'
        - name: RHPAM_JTA
          value: 'true'
        - name: KIE_SERVER_PERSISTENCE_DS
          value: 'java:/jboss/datasources/rhpam'
        - name: RHPAM_DRIVER
          value: postgresql
        - name: KIE_SERVER_PERSISTENCE_DIALECT
          value: org.hibernate.dialect.PostgreSQLDialect
        - name: RHPAM_USERNAME
          value: rhpam
        - name: RHPAM_PASSWORD
          value: Qgh3muCY
        - name: RHPAM_SERVICE_HOST
          value: rhpam-production-kieserver-postgresql
        - name: RHPAM_SERVICE_PORT
          value: '5432'
        - name: RHPAM_CONNECTION_CHECKER
          value: >-
            org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLValidConnectionChecker
        - name: RHPAM_EXCEPTION_SORTER
          value: >-
            org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLExceptionSorter
        - name: TIMER_SERVICE_DATA_STORE_REFRESH_INTERVAL
          value: '30000'
      securityContext:
        capabilities:
          drop:
            - KILL
            - MKNOD
            - SETGID
            - SETUID
        runAsUser: 1013390000
      ports:
        - name: jolokia
          containerPort: 8778
          protocol: TCP
        - name: http
          containerPort: 8080
          protocol: TCP
        - name: https
          containerPort: 8443
          protocol: TCP
        - name: ping
          containerPort: 8888
          protocol: TCP
      imagePullPolicy: Always
      volumeMounts:
        - name: kieserver-keystore-volume
          readOnly: true
          mountPath: /etc/kieserver-secret-volume
        - name: rhpam-production-rhpamsvc-token-z7r2h
          readOnly: true
          mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      terminationMessagePolicy: File
      image: >-
        registry.redhat.io/rhpam-7/rhpam-kieserver-rhel8@sha256:071d0add5cbcf5ba06b3f87034a0dc8d80590ae7efc13f6fafaee63bc54dc090
  serviceAccount: rhpam-production-rhpamsvc
  volumes:
    - name: kieserver-keystore-volume
      secret:
        secretName: rhpam-production-kieserver-app-secret
        defaultMode: 420
    - name: rhpam-production-rhpamsvc-token-z7r2h
      secret:
        secretName: rhpam-production-rhpamsvc-token-z7r2h
        defaultMode: 420
  dnsPolicy: ClusterFirst
  tolerations:
    - key: node.kubernetes.io/not-ready
      operator: Exists
      effect: NoExecute
      tolerationSeconds: 300
    - key: node.kubernetes.io/unreachable
      operator: Exists
      effect: NoExecute
      tolerationSeconds: 300
    - key: node.kubernetes.io/memory-pressure
      operator: Exists
      effect: NoSchedule
status:
  containerStatuses:
    - restartCount: 0
      started: true
      ready: true
      name: rhpam-production-kieserver
      state:
        running:
          startedAt: '2020-07-13T18:07:50Z'
      imageID: >-
        registry.redhat.io/rhpam-7/rhpam-kieserver-rhel8@sha256:071d0add5cbcf5ba06b3f87034a0dc8d80590ae7efc13f6fafaee63bc54dc090
      image: >-
        registry.redhat.io/rhpam-7/rhpam-kieserver-rhel8@sha256:071d0add5cbcf5ba06b3f87034a0dc8d80590ae7efc13f6fafaee63bc54dc090
      lastState: {}
      containerID: 'cri-o://76e9709a565fa8e2dc5703ace2be772806527ce762d1f550a0e6c350a2f47f64'
  qosClass: Burstable
  podIPs:
    - ip: 10.130.2.76
  podIP: 10.130.2.76
  hostIP: 172.18.2.67
  startTime: '2020-07-13T18:06:52Z'
  initContainerStatuses:
    - name: rhpam-production-kieserver-postgresql-init
      state:
        terminated:
          exitCode: 0
          reason: Completed
          startedAt: '2020-07-13T18:06:54Z'
          finishedAt: '2020-07-13T18:07:44Z'
          containerID: >-
            cri-o://cfb327e90dc9ac26165407c0708e3779997edc6c4ba6091a712c98042c4881ed
      lastState: {}
      ready: true
      restartCount: 0
      image: >-
        registry.redhat.io/openshift3/ose-cli@sha256:eda798d5c0f026b2221716f5df33fd97cd25bfb565f969e76e62815f1bd3a924
      imageID: >-
        registry.redhat.io/openshift3/ose-cli@sha256:eda798d5c0f026b2221716f5df33fd97cd25bfb565f969e76e62815f1bd3a924
      containerID: 'cri-o://cfb327e90dc9ac26165407c0708e3779997edc6c4ba6091a712c98042c4881ed'
  conditions:
    - type: Initialized
      status: 'True'
      lastProbeTime: null
      lastTransitionTime: '2020-07-13T18:07:45Z'
    - type: Ready
      status: 'True'
      lastProbeTime: null
      lastTransitionTime: '2020-07-13T18:08:34Z'
    - type: ContainersReady
      status: 'True'
      lastProbeTime: null
      lastTransitionTime: '2020-07-13T18:08:34Z'
    - type: PodScheduled
      status: 'True'
      lastProbeTime: null
      lastTransitionTime: '2020-07-13T18:06:54Z'
  phase: Running
```