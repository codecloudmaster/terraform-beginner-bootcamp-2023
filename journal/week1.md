
# Terraform Beginner Bootcamp 2023 - Week 1

## Fixing Tags

[How to Delete Local and Remote Tags on Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

Locall delete a tag
```sh
git tag -d <tag_name>
```

Remotely delete tag

```sh
git push --delete origin tagname
```

Checkout the commit that you want to retag. Grab the sha from your Github history.

```sh
git checkout <SHA>
git tag M.M.P
git push --tags
git checkout main
```


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

In terraform we can set two kinds of variables:
- Environment Variables - those you would set in your bash terminal eg. AWS credentials
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

## Fix using Terraform Refresh
A common error scenario that can prompt Terraform to refresh the contents of your state file is mistakenly modifying your credentials or provider configuration.

Run terraform plan -refresh-only to review how Terraform would update your state file.

```sh
terraform plan -refresh-only
```
  

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
28-aws-terrahouse-module
To prevent this we need to tell TF that we moved our resource to the module.

```tf
moved {
  from = aws_s3_bucket.website_bucket
  to   = module.terrahouse_aws.aws_s3_bucket.website_bucket
}
```

[Modules Refactoring](https://developer.hashicorp.com/terraform/language/modules/develop/refactoring)


## Considerations when using ChatGPT to write Terraform

LLMs such as ChatGPT may not be trained on the latest documentation or information about Terraform.

It may likely produce older examples that could be deprecated. Often affecting providers.


## Working with Files in Terraform


### Fileexists function

This is a built in terraform function to check the existance of a file.

```tf
condition = fileexists(var.error_html_filepath)
```

https://developer.hashicorp.com/terraform/language/functions/fileexists

### Filemd5

https://developer.hashicorp.com/terraform/language/functions/filemd5

### Path Variable

In terraform there is a special variable called `path` that allows us to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module
[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)


resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
}

## Tag 1.4.1 - 1.4.2

### Terraform Locals

Locals allows us to define local variables.
It can be very useful when we need transform data into another format and have referenced a varaible.

```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```
[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

### Terraform Data Sources

This allows use to source data from cloud resources.

This is useful when we want to reference cloud resources without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```
[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

### Working with JSON

We could use the JSON encode to create the JSON policy inline in the hcl.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

### IAM Policy 

Also we can use iam_policy_document as data sources

[Link to TF iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)

### Web-Site config

Also with CDN we do not need enabled website hosting settings for S3 bucket.

## Tag 1.5.0

### Changing the Lifecycle of Resources

[Meta Arguments Lifcycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data

The terraform_data implements the standard resource lifecycle, but does not directly take any other actions. You can use the terraform_data resource without requiring or configuring a provider. 
The terraform_data resource is useful for storing values which need to follow a manage resource lifecycle, and for triggering provisioners when there is no other logical managed resource in which to place them.

[ Terraform Data](https://developer.hashicorp.com/terraform/language/resources/terraform-data)

## Tag 1.5.1
## Provisioners

Provisioners allow you to execute commands on compute instances eg. a AWS CLI command.

They are not recommended for use by Hashicorp because Configuration Management tools such as Ansible are a better fit, but the functionality exists.

[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### [Local-exec](https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec)

This will execute command on the machine running the terraform commands eg. plan apply

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```

https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec

### Remote-exec

This will execute commands on a machine which you target. You will need to provide credentials such as ssh to get into the machine.

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```
https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec

First we (I) deployed local-exec provisioner in s3 object resource, but it is better to implement it as `terraform_data` resource 
with trigger - when content version changed.

## Tag 1.6.0
### For Each Expressions

For each allows us to enumerate over complex data types

```sh
[for s in var.list : upper(s)]
```

This is mostly useful when you are creating multiples of a cloud resource and you want to reduce the amount of repetitive terraform code.
In our case and on this tag we go throw public/assets/
`for_each = fileset("${var.assets_path}", "*.{jpg,png,gif}")`

[For Each Expressions](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)
