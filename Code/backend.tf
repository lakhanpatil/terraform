# In your Terraform configuration file (e.g., main.tf), define the remote backend.
terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "path/to/your/terraform.tfstate"
    region         = "us-east-1" # Change to your desired region
    encrypt        = true
    dynamodb_table = "your-dynamodb-table"
  }
}
