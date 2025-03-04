what is Terraform provider and how to use it?

# Terraform Provider
Terraform provider is a plugin that Terraform uses to interact with the API of a specific service. Terraform providers are responsible for understanding API interactions and exposing resources for Terraform to manage. Terraform providers are distributed separately from the core Terraform binary.

# How to use Terraform Provider
To use a provider in Terraform, you must configure it in the Terraform configuration file

Commands for this demo
Login azure account 

```bash
az login
```

Create a service principal

```bash
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<subscription_id>"
```

* Set env vars so that the service principal is used for authentication

export ARM_CLIENT_ID=""
export ARM_CLIENT_SECRET=""
export ARM_SUBSCRIPTION_ID=""
export ARM_TENANT_ID=""