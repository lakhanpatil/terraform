# Modules overview

As we manage our infrastructure with Terraform, we will create increasingly complext configurations. There is no limit on creating the single file terraform configuration files or directory but if we do we may encounter one or more problems such as:
- Understanding and navigating the configuration files will become increasingly difficult
- Updating the configuration will become more risky, as an update to one section may cause unintended consequences to other parts of your configuration.
- There will be an increasing amount of duplication of similar blocks of configuration.
- We may wish to share parts of our configuration between projects and teams, and will quickly find that cutting and pasting blocks of configuration between projects is error prone and hard to maintain.

## What are modules for?

Terraform modules are crucial for building scalable and maintainable infrastructure as code. They offer several key benefits:

**Organize configuration** - Modules make it easier to navigate, understand, and update our configuration by keeping related parts of our configuration together. By using modules, we can organize our configuration into logical components.

**Encapsulate configuration** - It means are putting related code into its own box. For example, all the code for your network (VPC, subnets, etc.) goes into a "network" module. All the code for your web servers goes into a "web-server" module.

- Imagine your entire Terraform code is a single, giant instruction manual. It's easy to get lost, and a small change on page 10 could accidentally mess up something on page 50.
- Modules act like putting specific chapters of that manual into separate, labeled folders.

**Reusability** - Instead of copying and pasting the same code for similar infrastructure components (e.g., a VPC, a web server, or a database), you can create a single module and reuse it across multiple projects or environments (development, staging, production). This saves time and reduces errors.

**Consistency and Standardization** - By using the same module for every deployment of a specific component, you ensure that your infrastructure is consistent and adheres to your organization's best practices. For example, a module for a public S3 bucket can enforce specific security settings, preventing accidental misconfigurations.

**Improved Collaboration** - Modules enable different teams to work on separate parts of the infrastructure without interfering with each other. A networking team could own a VPC module, while an application team uses it to deploy their services.

# What is a Terraform module?

A Terraform module is a set of Terraform configuration files in a single directory. Even a simple configuration consisting of a single directory with one or more .tf files is a module. You may have a simple set of Terraform configuration files such as:

- **main.tf:** This file contains the primary resource definitions for the module.

- **variables.tf:** Here, you define all the input variables that the module will accept. These variables allow the module to be customized.

- **outputs.tf:** This file defines the output values that the module will expose to the calling configuration. This is how you can pass information about the created resources (e.g., an IP address or an ARN) to other parts of your infrastructure.

- **versions.tf (optional but recommended):** This file specifies the required Terraform and provider versions.

- **README.md:** Essential for documentation, this file explains what the module does, its inputs, and its outputs, making it easy for others to use.

## Calling modules

Terraform commands will only directly use the configuration files in one directory, which is usually the current working directory. However, your configuration can use module blocks to call modules in other directories. When Terraform encounters a module block, it loads and processes that module's configuration files.

A module that is called by another configuration is sometimes referred to as a "child module" of that configuration.

## Local and remote modules

Modules can either be loaded from the local filesystem, or a remote source. Terraform supports a variety of remote sources, including the Terraform Registry, most version control systems, HTTP URLs, and HCP Terraform or Terraform Enterprise private module registries.

# Use Modules

## Use registry modules in configuration

Here we will use modules from the public Terraform Registry to provision an example environment on AWS by referencing the modules in Terraform configuration. The concepts you use in this tutorial will apply to any modules from any source.
