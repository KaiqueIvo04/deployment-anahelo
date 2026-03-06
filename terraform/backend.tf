terraform {
  backend "s3" {
    bucket  = "terraform-state-inventorycontrol"
    key     = "inventorycontrol/terraform.tfstate"
    region  = "sa-east-1"
    encrypt = true
  }
}