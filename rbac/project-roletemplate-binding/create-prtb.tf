# Create a new rancher2 Project Role Template Binding
resource "rancher2_project_role_template_binding" "kourosh-ro-prtb" {
  name = "kourosh-readonly-binding"
  project_id = "local:p-qjm9x"
  role_template_id = "rt-rkm6p"
  user_id = "u-vmnq6"
}
