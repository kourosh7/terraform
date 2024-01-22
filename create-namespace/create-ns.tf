# Create a new rancher2 Namespace
resource "rancher2_namespace" "foo" {
  name        = "foo"
  project_id  = "c-m-q9tj5smw:p-4p7nl"
  description = "foo namespace"
  resource_quota {
    limit {
      limits_cpu       = "100m"
      limits_memory    = "100Mi"
      requests_storage = "1Gi"
    }
  }
  container_resource_limit {
    limits_cpu      = "20m"
    limits_memory   = "20Mi"
    requests_cpu    = "1m"
    requests_memory = "1Mi"
  }
}
