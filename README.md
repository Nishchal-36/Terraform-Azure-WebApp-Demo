# Azure Web App Infrastructure with Terraform

This repository demonstrates how to deploy an Azure web application infrastructure using modular Terraform code. Key components—Resource Group, Networking, Load Balancer, and Virtual Machines—are each defined in separate modules for flexibility and clarity.

## How It Works

### Modules

- `resource-group`: Creates the Azure Resource Group.
- `networking`: Sets up Virtual Network and Subnets.
- `load-balancer`: Provisions an Azure Load Balancer.
- `virtual-machines`: Deploys Virtual Machines connected to your VNet/LB.

### Declarative Approach

You define what resources you want and their basic configuration in `.tf` files; Terraform takes care of the how.

### Variables and Outputs

Each module uses:
- Variables for input
- Outputs for sharing key values between modules

This makes your infrastructure reusable and composable.

## Quickstart

1. **Configure Variables**

   Edit `terraform.tfvars` or set values using environment variables for:
   - Location
   - VM sizes
   - Credentials

2. **Initialize Terraform**

terraform init


3. **Validate & Preview**

terraform validate terraform plan # Optional: See what will happen


4. **Deploy**

terraform apply


## Security Tips

- Do NOT hardcode sensitive info (like VM passwords).
- Use variables marked as `sensitive` or a secret manager.

## Repo Structure

/ ├── modules/ │ ├── resource-group/ │ ├── networking/ │ ├── load-balancer/ │ └── virtual-machines/ ├── main.tf ├── variables.tf ├── outputs.tf └── README.md


## Notes

- Designed for learning and customization—modify modules as needed for your scenarios.
- For production or enterprise use, review security and compliance settings.
- Consider using Azure Verified Modules for hardened templates.
