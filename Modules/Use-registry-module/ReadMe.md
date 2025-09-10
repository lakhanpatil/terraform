# Use registry modules in configuration

Open the [Terraform Registry page for the VPC module.](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/3.14.0)

This page displays information about the module and a link to the source repository. The page also has a dropdown interface to select the module version, module usage metrics, and example configuration.

The example configuration sets two arguments: `source `and `version`.

The `source` argument is required when you use a Terraform module. In the example configuration, Terraform will search for a module in the Terraform Registry that matches the given string. You could also use a URL or local module. Refer to the [Terraform documentation](https://developer.hashicorp.com/terraform/language/modules/configuration) for a full list of possible module sources.

The `version` argument is not required, but we highly recommend you include it when using a Terraform module. For supported sources, this argument specifies the module version Terraform will load. Without the version argument, Terraform will load the latest version of the module. In this tutorial, you will specify an exact version number for the modules you use. Refer to the module [documentation](https://developer.hashicorp.com/terraform/language/modules/syntax#version) for more methods to specify module versions.

Terraform treats other arguments in the module blocks as input variables for the module.

## Configuration files

Create a [terrform.tf](terraform.tf) file. This file defines the terraform block, which Terraform uses to configures itself. This block specifies this Terraform configuration must use the aws provider that is within the v4.49.0 minor release. It also requires that you use a Terraform version greater than v1.1.0.

Now create a [main.tf](main.tf) file which includes the the resource configuration. This configuration includes three blocks:

- The `provider "aws"` block configures the AWS provider. Depending on the authentication method you use, you may need to include additional arguments in the provider block.
- The `module "vpc"` block configures a Virtual Private Cloud (VPC) module, which provisions networking resources such as a VPC, subnets, and internet and NAT gateways based on the arguments provided.
- The `module "ec2_instances"` block defines two EC2 instances provisioned within the VPC created by the module.

## Set values for module input variables

Modules can contain both required and optional arguments. You must specify all required arguments to use the module. Most module arguments correspond to the module's input variables. Optional inputs will use the module's default values if not explicitly defined.

On the Terraform Registry page for the AWS VPC module, click on the Inputs tab to find the [input arguments](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/3.14.0?tab=inputs) that the module supports.

Review each argument defined in the `module "vpc"` and `module "ec2_instances"` block.

- The `count` meta-argument defines two EC2 instances. For a full list of module meta-arguments, refer to the [module documentation.](https://developer.hashicorp.com/terraform/language/modules/syntax#meta-arguments)

- The required `vpc_security_group_ids` and `subnet_id` arguments reference resources created by the `vpc` module. The [Terraform Registry module page](https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/3.5.0?tab=inputs) contains the full list of arguments for the ec2-instance module.

## Review root input variables

Using input variables with modules is similar to using variables in any Terraform configuration. A common pattern is to identify which module arguments you may want to change in the future, and create matching variables in your configuration's [variables.tf](variables.tf) file with sensible default values. You can pass variables to the module by referencing them as arguments in the module block. This makes your configuration flexible and easy to update.

Don't use variables for settings that will always be the same. If your company policy always requires a NAT gateway for every VPC, just set `enable_nat_gateway` to true directly in the module block. Using a variable here would be redundant and could lead to mistakes. It's best to use a variable only when a value needs to be configured differently depending on the situation.

Open [variables.tf](variables.tf) to review the input variable declarations and definitions.

## Review root output values

Modules also have output values. You can reference them with the `module.MODULE_NAME.OUTPUT_NAME` naming convention. In the Terraform Registry for the module, click on the Outputs tab to find [all outputs](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/3.14.0?tab=outputs) for the module.

You can reference module outputs in other parts of your configuration. Terraform will not display module outputs by default. You must create a corresponding output in your root module and set it to the module's output. This tutorial shows both cases.

Open [outputs.tf](outputs.tf) to find the module outputs.

In this example, the `vpc_public_subnets` output references the vpc module's `public_subnets` output, and `ec2_instance_public_ips` references the public IP addresses for both EC2 instances created by the module.

## Provision infrastructure

Now, apply your configuration to create your VPC and EC2 instances. Respond to the prompt with `yes` to apply the changes. The `vpc `and `ec2` modules define more resources than just the VPC and EC2 instances.

```
$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

  ## ...

Plan: 22 to add, 0 to change, 0 to destroy.

## ...

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

## ...

Apply complete! Resources: 22 added, 0 changed, 0 destroyed.

Outputs:

ec2_instance_public_ips = [
  "54.245.140.252",
  "34.219.48.47",
]
vpc_public_subnets = [
  "subnet-0cb9ff659ba66a7dd",
  "subnet-0c2788b6ffb0611c0",
]
```

Once Terraform completes, it will display the configuration outputs.

## Understand how modules work

When using a new module for the first time, you must run either `terraform init` or `terraform get` to install the module. When you run these commands, Terraform will install any new modules in the `.terraform/modules` directory within your configuration's working directory. For local modules, Terraform will create a symlink to the module's directory. Because of this, any changes to local modules will be effective immediately, without having to reinitialize or re-run `terraform get`.

After following this tutorial, your `.terraform/modules` directory will look like the following.
- .terraform/modules/
    - ec2_instances
    - modules.json
    - vpc

## Clean up your infrastructure

Before moving on to the next tutorial, destroy the infrastructure you created. Respond to the confirmation prompt with a `yes`.

```
$ terraform destroy
## ...

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

  ## ...

Plan: 0 to add, 0 to change, 22 to destroy.

Changes to Outputs:
  - ec2_instance_public_ips = [
      - "54.245.140.252",
      - "34.219.48.47",
    ] -> null
  - vpc_public_subnets      = [
      - "subnet-0cb9ff659ba66a7dd",
      - "subnet-0c2788b6ffb0611c0",
    ] -> null

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

## ...

Destroy complete! Resources: 22 destroyed.
```

## Next steps

In this tutorial, you learned how to use modules in your Terraform configuration, manage module versions, configure module input variables, and use module output values.
In the next tutorial, you will create a module for configuration that hosts a website in an S3 bucket.