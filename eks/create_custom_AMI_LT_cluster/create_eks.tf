data "template_file" "user_data" {
  template = <<EOF
#!/bin/bash -xe
/etc/eks/bootstrap.sh kourosh-eks-test
EOF
}
resource "aws_launch_template" "kourosh" {
  name                   = "kourosh"
  description            = "Launch Template for kourosh"
  vpc_security_group_ids = ["sg-0efe19034e75a6e01"]
  image_id               = "ami-003ae52fb340a7a5d"
  key_name               = "kourosh-aws-sa-east-1"
  instance_type          = "t3.medium"
  user_data              = base64encode(data.template_file.user_data.rendered)
  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = "30"
    }
  }
}
resource "rancher2_cluster" "eks_create_01" {
  name        = "kourosh-eks-test"
  description = "kourosh lab environment"
  eks_config_v2 {
    cloud_credential_id = rancher2_cloud_credential.aws.id
    name                = var.aws_eks_name
    region              = var.aws_region
    imported            = false
    public_access       = true
    kubernetes_version  = "1.30"
    subnets             = ["subnet-6f25e726", "subnet-5ce01307"]
    security_groups     = ["sg-0efe19034e75a6e01", "sg-07e52f6811c84c965"]
    node_groups {
      desired_size = 2
      max_size     = 5
      name         = "ng01"
      image_id     = "ami-003ae52fb340a7a5d"
      launch_template {
        id = aws_launch_template.kourosh.id
      }
    }
  }
}
