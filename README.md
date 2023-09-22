# Terraform Beginner Bootcamp 2023

## Semantic Versioning 2.0.0 :mage:

### Summary

This project is going to utilize semantic versioning for its tagging
[semver.org](https://semver.org/)

The general format is: **MAJOR.MINOR.PATCH**, eg. `1.0.1`


- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Consideration with Terraform CLI Changes

The Terraform CLI installation instruction have changed due to gpg keyring changes. So we need refer to the latest install CLI instructions via Terrafrom Docs and change installation script.

[Install the Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Consideration for linux distribution
This project is build against Ubuntu 
Please consider checking your Linux distribution.

[How to check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

```
cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=22.04
DISTRIB_CODENAME=jammy
DISTRIB_DESCRIPTION="Ubuntu 22.04.3 LTS"
```

### Refactoring into Bash script
While fixing the Terrafrom CLI gpg deprecation issues we notice that bash scripts steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI.

This bash script located here:  [./bin/install_terraform_cli.sh](./bin/install_terraform_cli.sh)

- This will keep the Gitpod Task File ([.gitpod.yml])(.gitpod.yml) tidy.
- This allow us an easier to debug and eecute manually Terraform CLI install.
- This willl allow better portability for other projects that need to install Terraform CLI.

#### Shebang
A Shebang tells the bash script wich interpreter to use

[Wiki Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))

```#!/bin/bash```


ChatGpt recomended to use this varian of Shebang

```#!/usr/bin/env bash```

#### Execution consideration
When executing the bash script we can use the `./` shorthand notation to execute the bash script.

eg. `./bin/install_terraform_cli.sh`

If we are using the script inside `.gitpod.yml` we need to point the script to the program to interpert it.
eg. `source ./bin/install_terraform_cli.sh` 

#### Linux permission consideration 

In order to make our bash script executable we need to change linux file permission to be executable at the user mode
```
chmod u+x ./bin/install_terraform_cli.sh
```

We could also alternatively 
```
chmod 744 bin/install_terraform_cli.sh 
```
[Link1](https://linuxopsys.com/topics/make-bash-script-executable-using-chmod)

[Link2](https://en.wikipedia.org/wiki/File-system_permissions)

[Link3](https://en.wikipedia.org/wiki/Chmod)

### Gitpod lifecicle (Before, Init Command)

We need to be carefully when using the Init because it will not rerun if we restart an existing workspace 

[Gitpod Docs](https://www.gitpod.io/docs/configure/workspaces/tasks)


### Working with Env Vars
We can list out all Environment Variables (Env Vars) in our system by using the `env` command.

We can filter specific variables using grep eg. `env | grep AWS`

#### Set and Unset Env Vars

In the terminal we can set using `export HELLO="World"` 

For unset we can use `unset HELLO`

We can set an Env Vars temporarily when just running a commands:

```sh
HELLO="World" ./bin/print_message

```

Within a bash script we can set Env Vars without writeing export eg.

```sh
#!/usr/bin/env bash
HELLO="World"
echo $HELLO
```

#### Printing Env Vars

We can print Env Vars using echo eg. `echo $HELLO`

#### Scoping of Env Vars

When you open a new bash terminals in VSCode or you Ubuntu native terminal app there is no info about ENv Vars that you set in original terminal window.

So if ypu want to set it globally you can set Env Vars in your `bash profile`

#### Persisting Env Vars in Gitpod 

We can persist Env Vars in Gitpod by storing them in Gitpod Secret Storage

```
gp env HELLO="World"
```

All future workspaces launched will set the Env Vars for all opened bash terminals. 

We can set Env Vars in `.Gitpod.yml` file, but it is not recommended and can use only for non-sensitive vars.

## AWS CLI Instalation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli.sh)

[Getting Started Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS Credentials are configured correctly by running this command

```sh
aws sts get-caller-identity

```
If it is succesfully you should see a JSON payload like this:
```json
{
    "UserId": "ASDA37TZZNH165PN6S3XR",
    "Account": "12345678912",
    "Arn": "arn:aws:iam::12345678912:user/terraform-bootcamp-user"
}
```

We'll need to generate AWS CLI credits from IAM User in order to the user AWS CLI.

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform registry which located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to APIs that will allow to create resources in terraform.
- **Modules** are a way to make large amount of terraform code modular, portable and sharable.

[Randon Terraform Provider](https://registry.terraform.io/providers/hashicorp/random)

### Terraform Console

We can see a list of all the Terrform commands by simply typing `terraform`


#### Terraform Init

At the start of a new terraform project we will run `terraform init` to download the binaries for the terraform providers that we'll use in this project.

#### Terraform Plan

`terraform plan`

This will generate out a changeset, about the state of our infrastructure and what will be changed.

We can output this changeset ie. "plan" to be passed to an apply, but often you can just ignore outputting.

#### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be execute by terraform. Apply should prompt yes or no.

If we want to automatically approve an apply we can provide the auto approve flag eg. `terraform apply --auto-approve`

#### Terraform Destroy

`teraform destroy`
This will destroy resources.

You can also use the auto approve flag to skip the approve prompt eg. `terraform apply --auto-approve`

#### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modulues that should be used with this project.

The Terraform Lock File **should be committed** to your Version Control System (VSC) eg. Github

#### Terraform State Files

`.terraform.tfstate` contain information about the current state of your infrastructure.

This file **should not be commited** to your VCS.

This file can contain sensentive data.

If you lose this file, you lose knowning the state of your infrastructure.

`.terraform.tfstate.backup` is the previous state file state.

#### Terraform Directory

`.terraform` directory contains binaries of terraform providers.

## Issues with Terraform Cloud Login and Gitpod Workspace

When attempting to run `terraform login` it will launch bash a wiswig view to generate a token. However it does not work expected in Gitpod VsCode in the browser.

The workaround is manually generate a token in Terraform Cloud

```
https://app.terraform.io/app/settings/tokens?source=terraform-login
```

Then create open the file manually here:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code (replace your token in the file):

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
    }
  }
}
```

We have automated this workaround with the following bash script [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)

