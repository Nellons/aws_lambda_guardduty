terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.56.1"
    }

    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "tf-user"
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}



