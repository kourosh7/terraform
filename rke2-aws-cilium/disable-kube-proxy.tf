# Create AmazonEC2 cloud credential
resource "rancher2_cloud_credential" "aws-creds" {
  name = "aws-creds"
  amazonec2_credential_config {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
  }
}

# Create AmazonEC2 machine config v2
resource "rancher2_machine_config_v2" "ec2machineconfig" {
  generate_name = "kourosh-ec2"
  amazonec2_config {
    ami =  var.aws_ami
    region = var.aws_region
    security_group = var.aws_sg
    subnet_id = var.aws_subnet
    vpc_id = var.aws_vpc
    zone = var.aws_zone
  }
}

# Create RKE2 cluster managed by Rancher with Cilium as the CNI and kube-proxy disabled
resource "rancher2_cluster_v2" "cilium-nokp" {
  name = "cilium-nokp"
  kubernetes_version = var.k8s_version
  rke_config {
    machine_pools {
      name = "pool1"
      cloud_credential_secret_name = rancher2_cloud_credential.aws-creds.id
      control_plane_role = true
      etcd_role = true
      worker_role = true
      quantity = 1
      drain_before_delete = true
      machine_config {
        kind = rancher2_machine_config_v2.ec2machineconfig.kind
        name = rancher2_machine_config_v2.ec2machineconfig.name
      }
    }
    chart_values = <<EOF
rke2-cilium:
  k8sServiceHost: localhost
  k8sServicePort: '6443'
EOF
    machine_global_config = <<EOF
cni: "cilium"
disable-kube-proxy: true
EOF
  }
}
