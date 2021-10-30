enable_cluster = true
prefix         = "foodyfood-prod"
k8s_version    = "1.21"
label          = "prod"
region         = "eu-central"
tags           = ["foodyfood-prod"]
pools = [
  {
    type : "g6-standard-4"
    count : 1
  }
]