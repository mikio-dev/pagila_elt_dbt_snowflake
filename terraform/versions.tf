terraform {
  required_version = ">= 1.1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.6"
    }

    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.35.0"
    }
  }
}

