# Notes

## What is Infrastructure as Code with Terraform?
```
- Infrastructure as Code (IaC) tools allow you to manage infrastructure with configuration files rather than through a graphical user interface.
- IaC allows you to build, change, and manage your infrastructure in a safe, consistent, and repeatable way by defining resource configurations that you can version, reuse, and share.
- Terraform is HashiCorp's infrastructure as code tool. It lets you define resources and infrastructure in human-readable, declarative configuration files, and manages your infrastructure's lifecycle.
- Terraform has several advantages
a. Terraform can manage infrastructure on multiple cloud platforms.
b. The human-readable configuration language helps you write infrastructure code quickly.
c. Terraform's state allows you to track resource changes throughout your deployments.
d. You can commit your configurations to version control to safely collaborate on infrastructure.
```

---

## Terraform Initialization
```
terraform init
- Initialize the working directory that contains your terraform code.
- It downloads the ancillary components as well as it downloads the modules and plugins It fetches the providers.
- It set up the backend for storing the terraform state file, a mechanism by which terraform tracks the resources.
- This is the first command that we will be running.
```

---

## Formatting and Validation
```
- The terraform fmt command automatically updates configurations in the current directory for readability and consistency.
- You can also make sure your configuration is syntactically valid and internally consistent by using the terraform validate command.
```

---

## Terraform Workflow
```
terraform workflow:
- write => plan => Apply
- write
  Write the infrastructure code
- plan
  Review the changes before applying
- Apply
  Apply to provision the infrastructure
```

---

## Plan, Apply, Destroy
```
terraform plan:
- This command reads the code and then creates and shows the plan of execution or deployment.
- This command will does not apply or deploy anything. It allows user to review the plan before executiing anything.
- At this stage authentication creds are used to connect to your infrastructure.

tf apply:
- It deploys the instructions and statements in the code.

tf destroy:
- This command deletes the infrastructure which is created by using terraform.
- It looks at the recorded, stored stat file created during deployment and destroys all resources created by your code.
- It should be used with caution as it is non-reversible command.
```

---

## Terraform Code Snippet

### Providers Block
```hcl
provider "aws" {
    region: "us-east-1"
}
```
```
provider => it is reserved keyword by terraform to represent the cloud providers name.
aws => cloud provider name. It can be any cloud provider like google, linode, azure etc.
region => This the configuration parameters. These parameters can be varies from one cloud provider to another.
```

### Resource Block
```hcl
resource "aws_instance" "web"{
    ami = " "
    instance_type = " "
}
```
```
resource => it is reserved keyword by terraform to represent the resource name that we are going to create.
aws_instance => resource provided by terraform provider.
web => User provided resource name.
In curly brackets we can add the resource config arguments.
resource address : aws_instance.web
using above address we can access the resource created by that object.
```

### Data Block
```hcl
data "aws_instance" "web"{
    instance_id = " "
}
```
```
data => it is reserved keyword by terraform to fetch and tracking details of already existing resource.
aws_instance => resource provided by terraform provider.
web => User provided resource name.
Within the curly brackets we can add the data source arguments.
resource address : data.aws_instance.web
- terraform executes code in files with the .tf extension.
```

---

## Terraform State Concept
```
- It is mainly used for Resource Tracking. It is way for terraform to keep a track on what has been deployed.
- Terraform state file is used to map the resources in code to resources deployed on a cloud.
- This file is a JSON dump containing all the metadata about your terraform deployment.
- Stored in a flat JSON file by default named "terraform.tfstate", but it can also be stored remotely, which works better in a team environment.
- Terraform provides the "terraform state" command to perform basic modifications of the state using the CLI.
- The plan provided by the terraform plan command is actually calculated by terraform state file by comparing what deployed earlier and what we are going to deploy now.
- Never lose the terraform state file because we will not be able to destroy or modified the infrastructure deployed by the terraform state file.
```

### Remote State Storage
```
- The terraform.tfstate can also be stored remotely, which works better in a team environment and its secure as well.
- AWS S3, Google storage are the couple of examples of the remote state storage.
- Remote state storage also allows locking state so parallel execution dont coincide.
- Also it can enable sharing output values with other Terraform configs or code.
```

---

## Purpose and Drawbacks of Terraform State
```
Purpose:
- Terraform requires some sort of database to map the terraform config to the real world.
- For some of the providers like AWS, terraform can use the AWS tags. Early versions of the Terraform had no state files and used the tags method.
- But the major issue was, not all resources support tags, and not all cloud providers support tags.
- It also helps to boost the deployment performance by caching the resource attributes for subsequent use.

Drawbacks:
- We cannot store the statefile on our local machine if you are working as team, you have store it somewhere in central repo like github or bitbucket.
- Every time if someone need to make a change they need to pull the latest stat file from repo, make change and then push it to the repo again. This can be solved using the remote backend.
```

### Remote Backend
```
- A remote backend stores the Terraform state file outside of your local file system and version control. Using S3 as a remote backend is a popular choice due to its reliability and scalability.
- We can create a S3 bucket in your AWS account to store the Terraform state. Ensure that the appropriate IAM permissions are set up. You can refer a backend.tf file from code folder.
- S3 backend also supports state locking and consistency checking via Dynamo DB which can be enabled by setting the dynamodb_table field to an existing DynamoDB table name.
- A single DynamoDB table can be used to lock multiple remote state files. Terraform generates key names that include the values of the bucket and key variables.
- We can also use the kubenetes secrets, postgres DB, azure blob storage or using REST client with http as well. We can use as per our need.
```

### State Locking
```
- If supported by your backend, Terraform will lock your state for all operations that could write state. This prevents others from acquiring the lock and potentially corrupting your state.
- State locking happens automatically on all operations that could write state. You won't see any message that it is happening.
- If state locking fails, Terraform will not continue. You can disable state locking for most commands with the -lock flag but it is not recommended.
```

---

## Terraform State Commands
```
- It is used for reading and editing the terraform state file.
- We can manually remove the resource from terraform state file so that its not managed by terraform.
- We can also list out the tracked resources and their details using the subcommands.
- Below are the couple of useful terraform state subcommands.
  terraform state list => List out all resources tracked by the terraform state file.
  terraform state rm   => To delete the resources from terraform state file. Note. It will not destory the resources which we removed from this command even if we run the terraform destroy command.
  terraform state show => Show the details of a resources tracked by the terraform state file.
```

---

## Terraform Variables
```
- Terraform variables allow you to write configuration that is flexible and easier to re-use.
- We can declare variables anywhere in configuration files but it is recommended putting them into a separate file names variables.tf.
- We can use -var command line flag to set the value of the variable which is in variables.tf.
- sample block of declaring the variable on the file.
```
```hcl
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}
```
```
variable => reserved keyword
aws_region => User provided variable name which we are going to use in the configuration to use the variable.

Variable blocks have three optional arguments:
  Description: A short description to document the purpose of the variable.
  Type: The type of data contained in the variable.
  Default: The default value.

Note: If you do not set a default value for a variable, you must assign a value before Terraform can apply the configuration.
      Terraform does not support unassigned variables.
- We can refer to variables in our configuration with var.<variable_name>.
- When Terraform interprets values, either hard-coded or from variables, it will convert them into the correct type if possible.
  So the instance_count variable would also work using a string ("2") instead of a number (2). But it will be recommended to use the most appropriate type.
- Terraform variables types: String, Number and Boolean.
- The variables used as a single value terraform calls it as single varialbe. Terraform also supports the collection of variables. Below are some of them.
  List: A sequence of values of the same type.
    declaraion: type       = list(string)
  Map: A lookup table, matching keys to values, all of the same type.
    declaraion: type        = map(string)
  Set: An unordered collection of unique values, all of the same type.
  Tuple: A fixed-length sequence of values of specified types.
  Object: A lookup table, matching a fixed set of keys to values of specified types

- terraform console command:
  The Terraform console command opens an interactive console that you can use to evaluate expressions in the context of your configuration.
  This can be very useful when working with and troubleshooting variable definitions.
- Entering variable values manually is time consuming and error prone. Instead, you can capture variable values in a file named terraform.tfvars.
  Terraform automatically loads all files in the current directory with the exact name terraform.tfvars or matching *.auto.tfvars.
  We can also use the -var-file flag to specify other files by name.

Q. why do we require variable.tf file if we have terraform.tfvars ?
Ans=> A variables.tf file is used to define the variables type and optionally set a default value . A terraform. tfvars file is used to set the actual values of the variables. Basically, the distinction between them is about declaration vs assignment.
```

---

## Terraform Outputs
```
- Terraform output values let you export structured data about your resources.
- We can add output declarations anywhere in your Terraform configuration files. However, we recommend defining them in a separate file called outputs.tf to make it easier for users to understand your configuration and review its expected outputs.
- Sample output.tf block
```
```hcl
output "vpc_id" {
  description = "ID of project VPC"
  value       = module.vpc.vpc_id
}
```
```
description argument is optional.
value: It will fetch the value of vps_id from the vpc module
```

---

## Terraform Modules
```
- A module is a container for multiple resources that are used together.
- A module consists of a collection of .tf and/or .tf.json files kept together in a directory.
- Modules are the main way to package and reuse resource configurations with Terraform.
- Every terraform configuration has at least one module, called root module, which consists of code files in your main working directory.
- One module can call other modules to include their resources into the configuration. A module that has been called by another module if often referred to as a chile module.
- Modules can be downloaded or referenced from:
  - Terraform public registry
  - A private registry
  - Your local system
- Modules are referenced using a module block.
```
```hcl
module "my-vpc-module" {
    source = "./module/vpc"       ===> Module source (mandatory)
    version = "0.0.5"             ===> Module version
    region = var.region           ===> Input parameters for module
}
```
```
- There are other parameters which can be allowed are: count, for_each, providers, depends_on
- Modules can optionally take input and provide outputs to plug back into your main code.

Accessing module outputs in our code:
```
```hcl
resource "aws_instance" "my-vpc-module" {
    ..... # other arguments
    subnet_id = module.my-vpc-module.subnet_id        ===> Module output
}
```

---

## Provisioners
```
- We can use provisioners to execute specific actions on the local machine or on a remote machine in order to prepare servers or other infrastructure objects for service.
- There are different types of provisioners in terraform, lets deep dive into the file, remote-exec, and local-exec.
  1. file Provisioners:
    - The file provisioner is used to copy files or directories f rom the local machine to a remote machine.
    - This is useful for deploying configuration files, scripts, or other assets to a provisioned instance. For example see file_provisioners.tf file on the Code folder.

  2. remote-exec Provisioner:
    - The remote-exec provisioner is used to run scripts or commands on a remote machine over SSH or WinRM connections. It's often used to configure or install software on provisioned instances.
    - For example see remote_exec_provisioners.tf file on the Code folder.

  3. local-exec Provisioner:
    - The local-exec provisioner is used to run scripts or commands locally on the machine where Terraform is executed.
    - It is useful for tasks that don't require remote execution, such as initializing a local database or configuring local resources.
    - For example see remote_exec_provisioners.tf file on the Code folder.
```

### Connection Block
```
- Most provisioners require access to the remote resource via SSH or WinRM and expect a nested connection block with details about how to connect.
- We can create one or more connection blocks that describe how to access the remote resource.
- Connection blocks don't take a block label and can be added within either a resource or a provisioner.
- A connection block added directly within a resource affects all of that resource's provisioners.
- A connection block added in a provisioner block only affects that provisioner and overrides any resource-level connection settings.
- For example you can look into the provisioners exa files or connection.tf file in Code folder.
- For Ref: https://developer.hashicorp.com/terraform/language/resources/provisioners/connection
```

---

## Built-in Functions
```
- Terraform comes pre-packeaged with functions to help you transform and combine values.
- User defined functions are not allowed only built in ones, which means we can not create the functions as usually create in a programming languages.
- Syntax to use the functions: function_name(arg1, arg2, ...)
- There are different types of build in functions terraform supports. You can find it here https://developer.hashicorp.com/terraform/language/functions
```

---

## Terraform Type Constraints (Collections and Structure)

### Collection Types
```
- Collection types allow multiple values of one primitive type to be grouped together. Constructors for these collections includes:
  . list (type)
  . map(type)
  . set(type)
- Example:
```
```hcl
variable "training" {
      type: list "string"
      default: ["ACG", "LA"]
}
```

### Structural Type
```
- Collection types allow multiple values of more than one primitive type to be grouped together. Constructors for these collections includes:
  . object(type)
  . tuple(type)
  . set(type)
- Example:
```
```hcl
variable "instructor"{
    type = object({
      name = string
      age = number
    })
  }
```
```
Dynamic Blocks:
- Dynamic blocks used to construct the repeatable nested configuration blocks inside Terraform resources.
- Supported within the following block types:
  . resources
  . data
  . provider
  . provisioner
- It is used make our code cleaner.
```

---

## Terraform fmt (Format)
```
- Terraform fmt command formats the code for readability, it does not change anything.
- It helps in keeping code consistent.
- It is safe to run at any time.
- it looks for the files with .tf extension and formats them.
- syntax: terraform fmt

  Scenario:
    - Before pushing code to the version control
    - After upgrading the terraform or its Modules
    - Any time we've made changes to the code.
```

---

## Terraform taint
```
- The terraform taint command informs Terraform that a particular object has become degraded or damaged
- Terraform represents this by marking the object as "tainted" in the Terraform state, and Terraform will propose to replace it in the next plan you create.
- This command is deprecated. For Terraform v0.15.2 and later, we recommend using the -replace option with terraform apply instead.
- Syntax: terraform taint [options] <address>
  The address argument is the address of the resource to mark as tainted

  Scenario:
    - To cause provisioners to run
    - Replace misbehaving resources forcefully
    - To mimic side effects of recreation not modeled by any attributes of the resources.
```

---

## Terraform import
```
- The terraform import command imports existing resources into Terraform.
- Import will find the existing resource from ID and import it into your Terraform state at the given ADDRESS.
- ADDRESS must be a valid resource address. Because any resource address is valid, the import command can import resources into modules as well as directly into the root of your state.
- Syntax: terraform import [options] ADDRESS-ID
  - ADDRESS must be a valid resource address
  - ID is dependent on the resource type being imported. For example, for AWS EC2 instances it is the instance ID (i-abcd1234) but for AWS Route53 zones it is the zone ID (Z12ABC4UGMOZ2N)

  Examples:
    terraform import aws_instance.foo i-abcd1234 => This will import an AWS instance into the aws_instance resource named foo
    terraform import module.foo.aws_instance.bar i-abcd1234 => This will import an AWS instance into the aws_instance resource named bar into a module named foo
```

---

## terraform Workspace
```
- (Section left empty in original)
```

---

**End of Notes**