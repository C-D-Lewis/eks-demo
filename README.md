# eks-demo

Taking a test drive of EKS Kubernetes on AWS using official modules and local
CLI.

Total resources: ~55, including managed IAM, KMS, ASG, and associated policies.


## Required

Install AWS CLI, Terraform, and `kubectl`.


## Create infrastructure

```
terraform init

terraform apply
```

## Using kubctl

Update config:

```
aws eks update-kubeconfig --region us-east-1 --name eks-demo-cluster
```

Check pods:

```
kubectl get pods
```
```
NAME           READY   STATUS    RESTARTS   AGE
eks-demo-pod   1/1     Running   0          10m
```

Check nodes:

```
kubectl get nodes
```
```
NAME                        STATUS   ROLES    AGE   VERSION
ip-10-0-1-91.ec2.internal   Ready    <none>   34m   v1.31.13-eks-ecaa3a6
```

## Test application

```
kubectl port-forward eks-demo-pod 8080:80
```

Then open localhost:8080 to see the nginx page.
