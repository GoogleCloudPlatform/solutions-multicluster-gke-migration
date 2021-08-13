# Migrating workloads to a multi-cluster GKE environment with Multi-Cluster Services and Multi-Cluster Ingress

This tutorial demonstrates how to use [Multi-Cluster Services (MCS)](https://cloud.google.com/kubernetes-engine/docs/concepts/multi-cluster-services)
and [Multi-Cluster Ingress (MCI)](https://cloud.google.com/kubernetes-engine/docs/concepts/multi-cluster-ingress)
to migrate workloads from a single-cluster Google Kubernetes Engine (GKE)
environment to a multi-cluster GKE environment.

For a detailed explaination, refer to the following documents:

- [Migrating workloads to a multi-cluster GKE environment with Multi-Cluster Services and Multi-Cluster Ingress](https://cloud.google.com/architecture/migrating-containers-multi-cluster-gke-ingress-services)

The tutorial guides you through a migration process. During the migration
process, you provision the environment with [Terraform](https://www.terraform.io/).

The scripts mentioned in this README show guidance and help when you execute them
without arguments. Follow that guidance to set the right command options.

## Dependencies

For this tutorial, you need the following tools:

- A [POSIX](https://wikipedia.org/wiki/POSIX)-compliant shell.
- [Google Cloud SDK](https://cloud.google.com/sdk) (tested with version `271.0.0`).
- Terraform (tested with version `v0.15.0`), if you prefer provisioning the environment with Terraform.

## Provisioning the environment with Terraform

If you prefer using Terraform to provision the environment for the tutorial, you:

1. Change your working directory to the root of this repository.
1. Initialize the default Google Cloud: `gcloud auth application-default login`
1. Initialize Terraform: `scripts/init-terraform.sh`
1. Change your working directory to the `terraform` directory: `cd terraform`
1. Ensure the configuration is valid: `terraform validate`
1. Apply the changes: `terraform apply`

## Registering the Config cluster, enabling MCI and MCS

To register the Config cluster, you:

1. Change your working directory to the root of this repository.
1. Run: `scripts/mci-mcs.sh`

## Deploying workloads

To deploy an example workload in the clusters you create:

1. Change your working directory to the root of this repository.
1. Deploy the workloads: `scripts/workloads.sh`
