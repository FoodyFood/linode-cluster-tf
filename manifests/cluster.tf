module "cluster" {
  source = "./modules/cluster"

  enable_cluster = var.enable_cluster

  k8s_version = var.k8s_version
  label       = var.label
  region      = var.region
  tags        = var.tags

  pools = var.pools

  prefix = var.prefix
}
