# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
---
apiVersion: networking.gke.io/v1
kind: MultiClusterService
metadata:
  name: productpage
spec:
  template:
    spec:
      selector:
        app: productpage
      ports:
      - name: http
        protocol: TCP
        port: 9080
...
---
apiVersion: networking.gke.io/v1
kind: MultiClusterIngress
metadata:
  name: productpage
  annotations:
    networking.gke.io/static-ip: "https://www.googleapis.com/compute/v1/projects/${GOOGLE_CLOUD_PROJECT}/global/addresses/example-workload-multi-cluster-ingress-global-ip"
spec:
  template:
    spec:
      backend:
        serviceName: productpage
        servicePort: 9080
      rules:
        - http:
            paths:
              - path: /productpage
                backend:
                  serviceName: productpage
                  servicePort: 9080
              - path: /static/*
                backend:
                  serviceName: productpage
                  servicePort: 9080
              - path: /login
                backend:
                  serviceName: productpage
                  servicePort: 9080
              - path: /logout
                backend:
                  serviceName: productpage
                  servicePort: 9080
              - path: /api/v1/*
                backend:
                  serviceName: productpage
                  servicePort: 9080
...
