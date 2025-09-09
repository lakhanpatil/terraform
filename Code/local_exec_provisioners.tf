resource "null_resource" "example" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "echo 'This is a local command'"
  }
}

#In this example, a null_resource is used with a local-exec provisioner to run a simple local command that echoes a message to the console whenever Terraform is applied or refreshed. The timestamp() function ensures it runs each time.
