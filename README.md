# gitlab-rancher-kubernetes

## Purpose
How to enable Auto DevOps GitLab CI/CD to a custom Rancher managed Kubernetes cluster

## Tested versions
- VM Ubuntu : 18.04
- Docker : 18.06
- GitLab : 11.9.6-ce
- Rancher : 2.1.8

##

```
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
#-----------------------
Token => token:      eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJnaXRsYWItbWFuYWdlZC1hcHBzIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImdpdGxhYi1zYS10b2tlbi1xNXdtbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJnaXRsYWItc2EiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJjZjFlMWE0Ni01YzZhLTExZTktYmViOC0wODAwMjdhYmVmNGUiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6Z2l0bGFiLW1hbmFnZWQtYXBwczpnaXRsYWItc2EifQ.mQ1nKhnABsMq68NRwKgWjHj-V9x5z5ky-H0k7SLTJpi5zjFcMrwOV_CKdjIECup7hnnbzExsHPP2Z61XrTYw69zWeIhzZClvuLhLFdbUuq0LsZdGhstP1vaHrM12SF5p9R9JEzpWlgNbeyYpq970CPlg1tHySLiWN1VFur5gX7a_j-Mj4LDb3jdwEl5H2y9UsVTNxRfeft5pEcCXi3giHT8CMGzO_M934iKmb-exN_SUYHAyCPrhiuRT6635X4-tKgo_AT6ev2eUGzJZleE4rA-RdTCtHA1u_WTxSHM9ipsEVun5ecEiL7pFVDW0agCnfoOi4OppOnAKdake0d_gPg
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJnaXRsYWItbWFuYWdlZC1hcHBzIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6InJ1bm5lci1naXRsYWItcnVubmVyLXRva2VuLTl3cGd6Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6InJ1bm5lci1naXRsYWItcnVubmVyIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiN2VlM2IwOTEtNWM2Yy0xMWU5LWJlYjgtMDgwMDI3YWJlZjRlIiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50OmdpdGxhYi1tYW5hZ2VkLWFwcHM6cnVubmVyLWdpdGxhYi1ydW5uZXIifQ.mGgFWyfy9wPnJUfJNLL_XZuPBXJ2u5EZF1MGNb3u8qDVs2Rn7JmMrbLoplDhZJycJ3RdFe_q-fSBzvJvhLeTcjugIKcBHr44-imC8ty_o-QSkHE5kiIG0eFRq6VJVAX1g25DYV7mgV2FyJ8lfLG5fDEQhGUoxD1yDTTjHNQzZc75jBYGuaRhBOsuWsJrZnpHbX9qbTEjfdxzuLWwy4cdU8a8T791Br6ivxVIkz1T5n2bgFWmYoahB3dEoYv5P18GvT7nXxIlJVhhmhcIq8B6mAk7B4Xs_1lsL_3M1isbeZp3Y493G6LcuOokPxdpvPrVLnVCXdh5frqrSg-2tB-82w
#-----------------------
clusterrolebinding.rbac.authorization.k8s.io/permissive-binding created
```

## References
- Official GitLab documentation : https://docs.gitlab.com/ce/user/project/clusters/ 
