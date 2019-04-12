# gitlab-rancher-kubernetes

## Context
In order to enable GitLab's AutoDevOps feature you need to fill the form "connecting GitLab with a Kubernetes cluster".
As I write this, the official documentation focuses on GKE cluster solution, so we only consider here an existing cluster managed by Rancher (which is my case).

The purpose here is to provide a script to help people to configure the existing cluster and fill the required GitLab fields marked by (\*) :
- Kubernetes cluster name
- Environment scope
- API URL \*
- CA Certificate \*
- Token \*
- Project namespace (optional, unique)
- RBAC-enabled cluster

## Features

- validate kubectl configuration
- display API URL
- create namespace gitlab-managed-apps
- create service account gitlab-sa
- create role gitlab-role
- create rolebinding gitlab-rb
- displays CA Certificate from secret gitlab-sa-token-XXXX
- displays token from secret gitlab-sa-token-XXXX
- set role permissive-binding

## Requirements
- ssh terminal session
- kubectl installed (snap recommended) and configured (~/.kube/config recommended)

## Setup
3 VM Ubuntu 18.04 with Docker 18.06 installed
- VM1 ubuntu1 192.168.56.11 : GitLab 11.9.6-ce installed (omnibus docker-compose installation)
- VM2 cluster1 192.168.56.101 : Rancher server stable 2.1.8, nfs server (for persistence volume claim)
- VM3 cluster2 192.168.56.102 : Rancher agent worker1 node

## Commands

### Clone this repo, execute autodevops.sh
```
git clone https://github.com/cdelaitre/gitlab-rancher-kubernetes.git
cd gitlab-rancher-kubernetes
./autodevops.sh
```

### Example
```
cdelaitre@ubuntu1 ~/workspace/gitlab-rancher-kubernetes (master) $ ./autodevops.sh

#-----------------------
kubectl check configuration
#-----------------------
kubectl Api Url
API URL => https://192.168.56.101/k8s/clusters/c-6qr44
#-----------------------
kubectl apply account
namespace/gitlab-managed-apps created
serviceaccount/gitlab-sa created
role.rbac.authorization.k8s.io/gitlab-role created
rolebinding.rbac.authorization.k8s.io/gitlab-rb created
#-----------------------
Get Secret
Secret => gitlab-sa-token-q5wmm
#-----------------------
Get CA Certificate
-----BEGIN CERTIFICATE-----
MIICwjCCAaqgAwIBAgIBADANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDEwdrdWJl
LWNhMB4XDTE5MDQxMDEyMTMwOVoXDTI5MDQwNzEyMTMwOVowEjEQMA4GA1UEAxMH
...
Gxf0CWcfwx9YKZhGjRvLYjDMslR4/56hOZtmG7Irn8+MKCmWSC2Gft3WkTJukRpM
AKF0a+Y6onL23copR2uEB7psRGal++TII08QeeCmIXtz4lc9egtKMrFF0+M5BUMN
W5oimYAS9egkwvdrX/rd/OhfKZdcZO+MkC6YHVH43SAYXC5s9kk=
-----END CERTIFICATE-----
#-----------------------
Token => token:      eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJnaXRsYWItbWFuYWdlZC1hcHBzIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6InJ1bm5lci1naXRsYWItcnVubmVyLXRva2VuLTl3cGd6Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6InJ1bm5lci1naXRsYWItcnVubmVyIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiN2VlM2IwOTEtNWM2Yy0xMWU5LWJlYjgtMDgwMDI3YWJlZjRlIiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50OmdpdGxhYi1tYW5hZ2VkLWFwcHM6cnVubmVyLWdpdGxhYi1ydW5uZXIifQ.mGgFWyfy9wPnJUfJNLL_XZuPBXJ2u5EZF1MGNb3u8qDVs2Rn7JmMrbLoplDhZJycJ3RdFe_q-fSBzvJvhLeTcjugIKcBHr44-imC8ty_o-QSkHE5kiIG0eFRq6VJVAX1g25DYV7mgV2FyJ8lfLG5fDEQhGUoxD1yDTTjHNQzZc75jBYGuaRhBOsuWsJrZnpHbX9qbTEjfdxzuLWwy4cdU8a8T791Br6ivxVIkz1T5n2bgFWmYoahB3dEoYv5P18GvT7nXxIlJVhhmhcIq8B6mAk7B4Xs_1lsL_3M1isbeZp3Y493G6LcuOokPxdpvPrVLnVCXdh5frqrSg-2tB-82w
#-----------------------
clusterrolebinding.rbac.authorization.k8s.io/permissive-binding created
```

## Notice

I need to change the *API URL* to the cluster agent worker1 node end-point : https://192.168.56.102:6443

## References
- Official GitLab documentation : https://docs.gitlab.com/ce/user/project/clusters/ 
