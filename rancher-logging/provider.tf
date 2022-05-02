terraform {
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = ">= 1.20.0"
    }
  }
}

provider "rancher2" {
  api_url   = ""
  token_key = ""
  bootstrap = false
  insecure=true
}
