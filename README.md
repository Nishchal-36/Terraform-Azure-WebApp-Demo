AZURE TERRAFORM DEPLOYMENT DEMO
This repository contains a modular Terraform configuration to deploy a scalable web application environment on Azure, including resource groups, virtual network, load balancer, and Windows VMs with IIS. The code is organized into modules for clarity, reusability, and easy maintenance, making it ideal for demo purposes and learning.

Table of Contents:
Overview
Architecture Components
Prerequisites
Setup Instructions
Configuration
Deployment Steps
Accessing the Deployment
Customization
Resources & Modules
Contributing
License

Overview

This Terraform project automates the deployment of an Azure environment, including:
A resource group for isolation
A virtual network with a subnet
A load balancer with NAT rules for RDP access
Multiple Windows VMs with IIS installed
Load balancer configuration with health probes and rules
The entire setup is modularized to enable straightforward modifications, scaling, and reuse.

Architecture Components

Resource Group: Logical container for all resources
Networking:
Virtual Network (VNet)
Subnet
Network Security Group with RDP and HTTP rules
Load Balancer:
Public IP
Backend pool connected to VMs
NAT rules for RDP access
Load balancing rule for HTTP traffic
Virtual Machines:
Windows Server 2022 instances
IIS setup with custom HTML page
Connection via load balancer + NAT rules

Prerequisites

Before starting, ensure you have:
An Azure subscription with sufficient permissions
Installed Terraform (version 1.0+ recommended)
Azure CLI installed (az) and logged in (az login)
Your Azure service principal credentials for Terraform (client_id, client_secret, tenant_id, subscription_id)

Setup Instructions

1. Clone this repository:
git clone <your-repo-url>
cd <cloned-folder>

3. Configure your Azure credentials:
Create a terraform.tfvars file based on the example and fill in your Azure credentials:

cp terraform.tfvars.example terraform.tfvars

# Edit terraform.tfvars with your Azure service principal info
3. Initialize Terraform:

terraform init
Deployment Steps

5. Plan the deployment:

terraform plan

7. Apply the configuration:

terraform apply
Monitor the progress; Terraform will showcase the resources it will create. Confirm when prompted to proceed.

Accessing the Deployment:

Once applied, note the output load_balancer_public_ip:

terraform output load_balancer_public_ip

Open this IP in your web browser to access the IIS web page served by your VMs.
To RDP into a VM, use the rdp_connection_strings output (or connect via your RDP client with the load balancer IP and assigned port).

Customization:

Adding more VMs: increase the vm_count variable in terraform.tfvars.
Changing messages: modify custom_messages in terraform.tfvars.
Using custom scripts: update the PowerShell template (install_iis.ps1.tpl) for further configuration.
Scaling: adjust load balancer rules, NAT rules, VM size, or subnet CIDRs in the respective variables and modules.

Resources & Modules:

This project's structure:

terraform-azure-webapp-demo/
│
├── modules/
│   ├── resource-group/
│   ├── networking/
│   ├── load-balancer/
│   └── virtual-machines/
│
├── main.tf
├── variables.tf
├── outputs.tf
└── terraform.tfvars.example

Each module focuses on a specific resource type, facilitating clean separation of concerns.

Contributing:

Contributions are welcome! Please fork the repository, create a feature branch, and submit a pull request with your improvements.

Final Notes
Review the terraform.tfvars file to suit your Azure setup.
Always run terraform plan before terraform apply to verify changes.
For more complex setups, consider adding environment-specific variables or state management.
Happy deploying! 🚀
Finished
