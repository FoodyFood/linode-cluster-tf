enable_cluster = true
prefix         = "foodyfood-prod"
k8s_version    = "1.21"
label          = "foodyfood-prod"
region         = "eu-central"
tags           = ["foodyfood-prod"]
pools = [
  {
    type : "g6-standard-2"
    count : 1
  }
]