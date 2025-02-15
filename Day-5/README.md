# File structure of Azure Terraform

## Introduction
This document will help you to understand the file structure of Azure Terraform.

## File structure
```
.
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── provider.tf
├── resource.tf
├── modules
│   ├── module1
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── terraform.tfvars
│   │   ├── provider.tf
│   │   ├── resource.tf
│   ├── module2
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── terraform.tfvars
│   │   ├── provider.tf
│   │   ├── resource.tf
├── environments
│   ├── dev
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── terraform.tfvars
│   │   ├── provider.tf
│   │   ├── resource.tf
│   ├── prod
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── terraform.tfvars
│   │   ├── provider.tf
│   │   ├── resource.tf


```

## Explanation
- `main.tf`: This file contains the main configuration of the infrastructure.
- `variables.tf`: This file contains the variables that are used in the main configuration.
- `outputs.tf`: This file contains the outputs of the main configuration.
- `terraform.tfvars`: This file contains the values of the variables.
- `provider.tf`: This file contains the provider configuration.
- `resource.tf`: This file contains the resources that are used in the main configuration.
- `modules`: This directory contains the modules that are used in the main configuration.
- `environments`: This directory contains the environments like dev, prod, etc. Each environment contains the main configuration files.

## Conclusion
This document helped you to understand the file structure of Azure Terraform.