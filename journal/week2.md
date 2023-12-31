# Terraform Beginner Bootcamp 2023 - Week 2

- [Terraform Beginner Bootcamp 2023 - Week 2](#terraform-beginner-bootcamp-2023---week-2)
  * [Working with Ruby](#working-with-ruby)
    + [Bundler](#bundler)
      - [Install Gems](#install-gems)
      - [Executing ruby scripts in the context of bundler](#executing-ruby-scripts-in-the-context-of-bundler)
    + [Sinatra](#sinatra)
  * [Tag 2.0.0](#tag-200)
    + [Terratowns Mock Server](#terratowns-mock-server)
    + [Running the web server](#running-the-web-server)
  * [Tag 2.1.0 - 2.2.0](#tag-210---220)
    + [Custom provider on Go language](#custom-provider-on-go-language)
  * [Tag 2.3.0](#tag-230)
    + [CRUD](#crud)
  * [Tag 2.4.0-2.6.0](#tag-240-260-final)
    + [Working with git](#working-with-git)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>


# Terraform Beginner Bootcamp 2023 - Week 2

## Working with Ruby

### Bundler`From now I decided to create paragraphs in relation to tags in the project.`

Bundler is a package manager for runy.
It is the primary way to install ruby packages (known as gems) for ruby.

#### Install Gems

You need to create a Gemfile and define your gems in that file.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the `bundle install` command

This will install the gems on the system globally (unlike nodejs which install packages in place in a folder called node_modules)

A Gemfile.lock will be created to lock down the gem versions used in this project.

#### Executing ruby scripts in the context of bundler

We have to use `bundle exec` to tell future ruby scripts to use the gems we installed. This is the way we set context.

### Sinatra

Sinatra is a micro web-framework for ruby to build web-apps.

Its great for mock or development servers or for very simple projects.

You can create a web-server in a single file.

https://sinatrarb.com/

## Tag 2.0.0
`Tag 1.8.0-1.9.0 missing because I decided to skip them to be on the same tag with original project/bootcamp.`
### Terratowns Mock Server

### Running the web server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in the `server.rb` file.

## Tag 2.1.0 - 2.2.0
### Custom provider on Go language
We created custom provider on Go and added it to tf config. As an endpoint we add our Mock server on Ruby? that we implemented before.
```
required_providers {
    
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
...
    provider "terratowns" {
    endpoint = "http://localhost:4567"
    user_uuid="e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
    token="9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
  
}
```

Note, that if our tf state file on terraform.io we need to set our workspace settings to local to avoid errors with access from remote to our custom local providers.

## Tag 2.3.0 
### CRUD

Terraform Provider resources utilize CRUD.

CRUD stands for Create, Read Update, and Delete

https://en.wikipedia.org/wiki/Create,_read,_update_and_delete

## Tag 2.4.0-2.6.0 Final


We tested upload to the productions server on http://terratowns.cloud
And created possibility for multihome uploads using `locals` and `for_each` fucnctions in TF

```tf
module "terrahome_aws" {
	source = "./modules/terrahome_aws"
	for_each = local.homes_path_aws
	public_path = each.value.public_path
	user_uuid = var.teacherseat_user_uuid
	content_version = each.value.content_version
  }
  

  resource "terratowns_home" "home" {
	for_each = local.homes
	name = each.value.name
	description = each.value.description
	domain_name = each.value.domain_name
	town = each.value.town
	content_version = each.value.content_version
  }
```

In the public directory we have subdirectorie for homes in terratown which consist of the following:
- index.html
- error.html
- /assets

All top level files in `assets` will be copied, but not any subdirectories.

### Working with git
How to merge main branch to current:
```bash
git branch -a  # Lists all local and remote branches, and the current branch is highlighted.
git checkout branch-name   # Switch to the desired branch.
git fetch origin # Fetch changes from the remote repository (usually named 'origin').
git merge main   # Merge the main branch into your current branch.
git commit -m "Merge main branch into current branch"
git push origin branch-name  # Replace 'branch-name' with your current branch.


```
