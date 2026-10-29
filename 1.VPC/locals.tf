locals {
    project = "josue-app"
    region = "us-east-2"
    vpc_cidr = "10.0.0.0/16"

    azs = ["us-east-2a", "us-east-2b"]
    public_subnets = {
        a = {
          cidr = "10.0.1.0/24"
          az = "us-east-2a"
        }
        b = {
          cidr = "10.0.2.0/24"
          az = "us-east-2b"
        }
    }
    
    private_subnets = {
        a = {
            cidr = "10.0.3.0/24"
            az = "us-east-2a"
        }

        b = {
            cidr = "10.0.4.0/24"
            az = "us-east-2b"
        }
    }

}