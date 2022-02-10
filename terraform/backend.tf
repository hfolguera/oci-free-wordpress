terraform {
  backend "s3" {
    bucket                      = "os-terraform-001"
    key                         = "terraform.tfstate"
    region                      = "eu-frankfurt-1"
    endpoint                    = "https://frvn5ignckvl.compat.objectstorage.eu-frankfurt-1.oraclecloud.com"
    #shared_credentials_file     = "./s3.credentials" # Credentials must be set as environment variables
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}
