output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.eks.cluster_security_group_id
}

output "kubectl_config" {
  description = "kubectl config as generated by the module."
  value       = module.eks.kubeconfig
}

output "config_map_aws_auth" {
  description = "A kubernetes configuration to authenticate to this EKS cluster."
  value       = module.eks.config_map_aws_auth
}

output "cluster_oidc_issuer_url"{
  description = "provisioned eks cluster oidc url"
  value       = module.eks.cluster_oidc_issuer_url
}

output "oidc_provider_arn"{
  description = "provisioned eks cluster oidc arn"
  value       = module.eks.oidc_provider_arn
}

output "UshurLinodeInstance_EKS_role" {
  description = "provisioned IAM roles Ushur Linnode service account"
  value      = aws_iam_role.UshurLinodeInstance_EKS_role[0].arn
}

#Create a output file

locals {
  output_content = <<-EOT
    ##
    ## Outputs
    ##
    cluster end point = ${module.eks.cluster_endpoint}
    cluster oidc issuer url = ${module.eks.cluster_oidc_issuer_url}
    cluster oidc provider arn = ${module.eks.oidc_provider_arn}
    UshurLinodeInstance_EKS_role = ${aws_iam_role.UshurLinodeInstance_EKS_role[0].arn}
    #############################################################################
  EOT
}

resource "local_file" "output_file" {
  filename = "./output-${var.cluster_name}"
  content  = local.output_content
}



