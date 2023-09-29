# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

### Terraform Cloud Variables

In terraform we can set two kind of variables:
- Enviroment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibliy in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id"`

### var-file flag

- TODO: document this flag

### terraform.tvfars

This is the default file to load in terraform variables in blunk

### auto.tfvars

- TODO: document this functionality for terraform cloud

### order of terraform variables

- TODO: document which terraform variables takes presendence.

## What happens if we lose our state file?

If you lose your statefile, you most likley have to tear down all your cloud infrastructure manually.

You can use terraform import but it won't for all cloud resources. You need check the terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

`Note`: During changing configuration from random bucket name to static, we lose our s3 bucket created by random provider settings. 
And we needed ro run Terraform apply twice: after first we destroyed random provider settings, and then to create our new bucket, even if we run terraform import before this commands. Maybe we needed to do remove first it from terraform state.

### Remove a Resource from Terraform State

To remove a resource from Terraform state, follow these steps:

#### Step 1: Identify the Resource Address

First, identify the address of the resource in your Terraform state. You can list the resources and their addresses using the following command:

```bash
terraform state list
```
#### Step 2: Remove the Resource from Terraform State

Use the terraform state rm command to remove the identified resource from Terraform state. Replace `<RESOURCE_ADDRESS>` with the actual address of the resource.

```bash
terraform state rm <RESOURCE_ADDRESS>
```
#### Step 3: Update Terraform Configuration

After removing the resource from the state, update your Terraform configuration to reflect the removal. This involves removing the corresponding resource block from your configuration file.

#### Step 4: Apply the Changes

Run terraform apply to apply the changes to your infrastructure.

```bash
terraform apply
```

This will update your infrastructure to reflect the changes in your Terraform configuration.

Note: Removing a resource from the state does not automatically destroy the resource in the cloud provider. It only removes the resource from Terraform's tracking. If the resource still exists in the cloud provider, Terraform will not manage it.

Always exercise caution when making changes to your Terraform state and configurations, especially when dealing with live infrastructure.



### Fix Manual Configuration

If someone goes and delete or modifies cloud resource manually through ClickOps. 

If we run Terraform plan is with attempt to put our infrstraucture back into the expected state fixing Configuration Drift

## Terraform Modules

### Terraform Module Structure

It is recommend to place modules in a `modules` directory when locally developing modules but you can name it whatever you like.

### Passing Input Variables

We can pass input variables to our module.
The module has to declare the terraform variables in its own variables.tf
We need to put it on root module along with providers.

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules Sources

Using the source we can import the module from various places eg:
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```

[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

### Module Refactoring.

When we vreate a module Terraform compares previous state with new configuration, correlating by each module or resource's unique address. Therefore by default Terraform understands moving or renaming an object as an intent to destroy the object at the old address and to create a new object at the new address.
To prevent this we need to tell TF that we moved our resource to the module.


```tf
moved {
  from = aws_s3_bucket.website_bucket
  to   = module.terrahouse_aws.aws_s3_bucket.website_bucket
}
```

[Modules Refactoring](https://developer.hashicorp.com/terraform/language/modules/develop/refactoring)