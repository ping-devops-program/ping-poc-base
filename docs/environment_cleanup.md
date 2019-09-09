# Notes on Cleaning up Various Environment Aspects

## EKS
Delete Cluster:
1. Make sure you are using the aws profile for the cluster admin
2. 
```
eksctl delete cluster --name=ping-poc-cluster --profile=aws_admin
```
3. ensue the cloudformation stacks are deleted. 

