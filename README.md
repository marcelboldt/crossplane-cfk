
# Crossplane-CfK

These are some experiments on managing CfK with Crossplane.

One goal would be to create a package i.e. an ops team must just install this package and have the dev teams create Claims to spin up clusters as needed. That may be used also as a starting point to create Compositions to support the claim in specific infrastructure.


## Cfk via Crossplane, quick start

This creates a CompositeResource for CfK and its Composition targeting the local k8s cluster, and a claim to spin up a dev cluster. 

1. Install Crossplane:

see https://crossplane.io/docs/v1.9/reference/install.html

```
kubectl create namespace crossplane-system

helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo update

helm install crossplane --namespace crossplane-system crossplane-stable/crossplane
```

2. Install Providers:

See remark on RBAC below!

```
kubectl apply -f helm-provider.yaml -n crossplane-system
kubectl apply -f k8s-provider.yaml -n crossplane-system
```

3. Install Confluent Platform / CfK:

```
kubectl apply -f XRD-clusters.platform.confluent.io.yaml // the CompositeResourceDefinition
kubectl apply -f comp-CPCluster.yaml  // Composition implementing the CompositeResource
```

4. Create a dev cluster using a claim:

```
kubectl create namespace dev
kubectl apply -f devCPcluster.yaml -n dev
```


## RBAC

The crossplane providers' service accounts need the rights to talk to the k8s api and create the resources. Crossplane 
RBAC manager creates, updates and binds ClusterRoles and ClusterRoleBindings. 

Neither a provider nor the crossplane controller has permission to create namespaces in the cluster it is installed into.

See also https://github.com/crossplane/crossplane/blob/master/design/design-doc-rbac-manager.md


# Individual components

Instead of using a CompositeResource, the individual Crossplane resources can be applied to spin up infrastructure - see following.

## Deploy cfk locally via helm

```
$ kubectl apply -f helm-provider.yaml -n crossplane-system

$ kubectl apply -f cp-cfk-helm.yaml -n crossplane-system
```

## Azure

need to provide azure credentials first... see https://crossplane.io/docs/v1.9/cloud-providers/azure/azure-provider.html
```
// deploy the provider
kubectl apply -f az-provider.yaml -n crossplane-system

//deploy some AKS cluster
kubectl apply -f xp-aks.yaml -n crossplane-system
```
