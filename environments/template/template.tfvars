enable_cluster = false
prefix         = "template"
k8s_version    = "1.21"
label          = "template"
region         = "eu-central"
tags           = ["template"]
pools = [
  {
    type : "g6-standard-2"
    count : 1
  }
]