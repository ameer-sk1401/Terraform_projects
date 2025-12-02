# ☁️ Static Website Hosting on AWS & Azure using Terraform

---

## 🚀 Quick Start

### Prerequisites

- [Terraform](https://www.terraform.io/downloads) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) (for AWS projects)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) (for Azure projects)

### AWS Setup

```bash
# Configure AWS credentials
aws configure

# Or export environment variables
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_REGION="us-east-1"
```

### Azure Setup

```bash
# Login to Azure
az login

# Set subscription
az account set --subscription "your-subscription-id"
```

---

## 📚 Projects

### AWS Projects

#### 1. S3 Static Website

Deploy a static website on S3 with public access.
Clone this repo and run

```bash
cd aws/
terraform init
terraform validate
terraform plan
terraform apply
```

**Resources Created:**

- S3 bucket with website hosting
- Bucket policy for public access
- Website files (index.html, error.html)

---

### Azure Projects

#### 1. Static Website

Host a static website on Azure Storage.

```bash
cd azure
terraform init
terraform validate
terraform plan
terraform apply
```

**Resources Created:**

- Resource Group
- Storage Account (StorageV2)
- Static website configuration
- Blob storage with HTML files

---

## 🛠️ Common Commands

### Initialize

```bash
terraform init
```

### Plan (preview changes)

```bash
terraform plan
```

### Apply (create resources)

```bash
terraform apply
terraform apply -auto-approve  # Skip confirmation
```

### Destroy (delete resources)

```bash
terraform destroy
terraform destroy -auto-approve  # Skip confirmation
```

### View Outputs

```bash
terraform output
terraform output -raw <output_name>
```

### Format Code

```bash
terraform fmt
terraform fmt -recursive
```

### Validate Configuration

```bash
terraform validate
```

---

## 📝 Configuration

Each project contains:

- `main.tf` - Main infrastructure code
- `variables.tf` - Variable definitions
- `outputs.tf` - Output values

---

## 🔐 Security Notes

- **Never commit** `terraform.tfvars` or `*.tfstate` files
- Use `.gitignore` to exclude sensitive files
- Store credentials in environment variables or secret managers
- Use IAM roles/managed identities when possible

---

## 🧹 Cleanup

Always destroy resources after testing to avoid charges:

```bash
cd <project-directory>
terraform destroy -auto-approve
```

---

## 💰 Cost Considerations

Most projects use free-tier eligible resources:

- **AWS:** t2.micro EC2, S3 storage (first 5GB free)
- **Azure:** LRS storage (first 5GB free)

**Recommendation:** Destroy resources after practice to avoid unexpected charges.

---

## 📖 Learning Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Azure Provider Docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)

---

## ⭐ Show Your Support

Give a ⭐ if you found these projects helpful!
