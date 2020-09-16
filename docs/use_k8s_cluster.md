## FOR USERS - To set up usage on an existing cluster
### 1. Install CLIs
  1. awscli
    
      ```
      brew install python3
      pip3 install awscli --upgrade --user
      ```

  2. kubectl:
https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-macos
      ```
      curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl

      chmod +x ./kubectl

      sudo mv ./kubectl /usr/local/bin/kubectl

      KUBECONFIG="$HOME/.kube/config"

      kubectl version
      ```
      > make sure the file at `$HOME/.kube/config` is valid, you may have to delete and recreate it. 
  3. kubectx: 
    ```
    brew install kubectx
    ```


### 2. Configure K8s Cluster Contexts. 
1. Get AWS key/secret from ADMIN for 
2. Configure `aws` to use correct profile:

    1. configure aws cli
        ```
        aws configure --profile base_eks_user
        ```

    2. Set created profile as default for current shell: 
        ```
        export AWS_DEFAULT_PROFILE=base_eks_user
        ```

3. Add the kubernetes context to your kubectl config. 
  ```
  aws eks --region <region>
  update-kubeconfig --name ping-poc-base
  ```

4. Set the new context and namespace:
  view the contexts:
    ```
    kubectx
    ```
  rename to make easier to switch:
    ```
    kubectx <NEW_NAME>=<NAME>
    ```
  switch to the context:
    ```
    kubectx <NEW_NAME>
    ```

5.  Test!: 
    ```
    kubectl create deployment pingdataconsole --image pingidentity/pingdataconsole:edge
    ```
    > Note: look to see that this deployment is attached to your namespace. 
    ```
    kubectl delete deployment pingdataconsole
    ```


### NEXT: Use Ping-Cloud-Base

Consider using this repo to as your base install: 
https://github.com/pingidentity/ping-cloud-base

This provides: 
- a great, maintained, baseline install of PingAccess, PingFederate, and PingDirectory. 
- automatically sets up hostnames on AWS Route53 
- configurable install using Kubernetes native config tool `kustomize`

You can follow the guidance from the ping-cloud-base repo or you can use just the relevant tools. 
To pick what you want to apply: 
1. find a tool you like. 
2. `kustomize build` it to see what you would be deploying.
3. output kustomize build to a file then run kubectl apply -f, or pipe to kubectl apply. 

Here's some important ones:

external-dns - used to add route53 records that are requested from the cluster:
```
kustomize build https://github.com/pingidentity/ping-cloud-base/k8s-configs/cluster-tools/service-discovery/external-dns > external-dns.yaml

kubectl apply -f external-dns.yaml
```

nginx ingress controller - sets up an NLB and allows you to expose apps through it. 

```
kustomize build https://github.com/pingidentity/ping-cloud-base/k8s-configs/cluster-tools/ingress/nginx/public > public-ingress.yaml

kubectl apply -f public-ingress.yaml
```

For ping deployments, the devops-getting-started repo is great: 

for a pingfederate cluster just set your kubernetes namespace then deploy. 
```
export PING_IDENTITY_K8S_NAMESPACE=default
kustomize build https://github.com/pingidentity/pingidentity-devops-getting-started/20-kubernetes/06-clustered-pingfederate > pingfederate.yaml
```

and if you deployed the nginx yaml, you can expose your application: 
https://github.com/pingidentity/pingidentity-devops-getting-started/blob/master/20-kubernetes/10-ingress/pingfederate-cluster-ingress.yaml


