# README Documentation for Deploying Terraform Code

## Introduction

This repository demonstrates how to automate file transfers from Amazon S3 to Amazon EFS using AWS Lambda. The setup leverages Terraform for infrastructure as code, facilitating easy deployment and management of AWS resources. This guide provides instructions for deploying the Terraform code using Terraform Cloud with VCS connection and a CLI setup for those preferring a local approach.

## Prerequisites

- An AWS account with appropriate permissions.
- Terraform installed on your local machine.
- A Terraform Cloud account (if using Terraform Cloud).
- Version Control System (VCS) repository (e.g., GitHub, GitLab).


## Terraform Cloud Setup (VCS Connection)

### Step 1: Create a New Workspace

1. Log in to your Terraform Cloud account.
2. Navigate to the "Workspaces" section.
3. Click on "New Workspace".
4. Choose "Version Control Workflow".
5. Connect to your VCS provider (e.g., GitHub, GitLab) and select the repository containing your Terraform code.
6. Name your workspace and create it.

### Step 2: Configure Workspace Variables

1. In your workspace, go to the "Variables" tab.
2. Add the following environment variables:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
3. (Optional) Add any other necessary variables specified in `variables.tf`.

### Step 3: Run Terraform

1. In your workspace, navigate to the "Runs" tab.
2. Click "Queue plan" to start a new plan.
3. Review the plan output and confirm the apply.

## Local Setup (CLI)

### Step 1: Install Terraform

Follow the instructions on the [Terraform website](https://www.terraform.io/downloads.html) to install Terraform on your local machine.

### Step 2: Configure AWS CLI

Ensure you have the AWS CLI installed and configured with appropriate credentials:

```bash
aws configure
```
### Step 3: Initialize Terraform
Navigate to the root directory of your Terraform code and run:

```bash
terraform init
```
### Step 4: Review and Apply Configuration
1. Review the Terraform plan to ensure everything is correct:
```bash
terraform plan
```
2. Apply the configuration to deploy the resources:
```bash
terraform apply
```
### Step 5: Provide Variables
If your variables.tf file includes required variables, you can pass them via a .tfvars file or directly in the CLI:

Using a .tfvars file:
```bash
terraform apply -var-file="yourfile.tfvars"
```
Directly in the CLI:
```bash
terraform apply -var="variable_name=value"
```
## Post-Deployment
Once the deployment is complete, you can verify the resources in the AWS Management Console:

S3 Bucket: Check if the bucket is created and ready to receive files.
EFS File System: Verify the creation of the EFS file system and mount targets.
Lambda Function: Confirm that the Lambda function is created and configured correctly.
EC2 Instance: Check the EC2 instance for the correct setup and mounted EFS file system.

## Cleaning Up
To clean up and remove all resources created by Terraform, run:
```bash
terraform destroy
```
## Troubleshooting
- Ensure all required variables are correctly set.
- Verify your AWS credentials and permissions.
- Check Terraform logs for detailed error messages.
For further assistance, refer to the [Terraform Documentation](https://www.terraform.io/) or open an issue in the repository.
  