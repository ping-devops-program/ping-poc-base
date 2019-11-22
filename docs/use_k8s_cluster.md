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
    kubectl create deployment hello-node --image=gcr.io/hello-minikube-zero-install/hello-node
    ```
    > Note: look to see that this deployment is attached to your namespace. 
    ```
    kubectl delete deployment hello-node
    ```


### NEXT: Use Ping-Cloud-Base

Consider using this repo to as your base install: 
https://github.com/pingidentity/ping-cloud-base

This provides: 
- a great, maintained, baseline install of PingAccess, PingFederate, and PingDirectory. 
- automatically sets up hostnames on AWS Route53 
- configurable install using Kubernetes native config tool `kustomize`