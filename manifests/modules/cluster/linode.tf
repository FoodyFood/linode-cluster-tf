resource "linode_lke_cluster" "cluster" {
  count       = var.enable_cluster ? 1 : 0
  k8s_version = var.k8s_version
  label       = var.label
  region      = var.region
  tags        = var.tags

  dynamic "pool" {
    for_each = var.pools
    content {
      type  = pool.value["type"]
      count = pool.value["count"]
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}