locals {
  tags_staging = {
    environment = "staging"
    // add more tags here if needed
  }

  tags_production = {
    environment = "production"
    // add more tags here if needed
  }

  tags_default = {
    environment = "shared"
    // add more tags here if needed
  }
}
