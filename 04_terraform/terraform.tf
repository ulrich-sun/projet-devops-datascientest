terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.6"
    }
    aws = {
      source = "hashicorp/aws"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}