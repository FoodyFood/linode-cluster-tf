# Personal Cluster (using terraform) On Linode.com

This repo builds my own personal cluster, if you clone this repo and push it to your account, it will create a GitHub workflow that then builds your cluster.

The anifests folder is the actual IaC, don't worry too much about it. The main place you want to go is environments. In here you will see my 'foodyfood-prod' cluster and also a template you can use to make your own.

If you run everything as is it will build you a very small cluster of 1 node, 4 vCPU, and 8GB memory.

Take a look in this file to adjust the size, location, or label of the cluster.

```bash
./environments/foodyfood-prod/foodyfood-prod.tfvars
```

Once deployed, changes should be made via pull request. The GitHub workflow has a seperate path for pull requests that will validate and tf plan the change before applying. It's also just good practice to have someone else review infrastructure changes. 

<br>

## Create a linode token

Log into Linode, and create a personal access token

https://cloud.linode.com/profile/tokens

<br>

## Configure GitHub Workflow Linode Access

![github-secret](/docs/github-secret.PNG)

<br>

## Save the token for TF to use locally

Update a file in the manifestss directory called 'tokens.tf' with this contents:

```json
  variable "linode_api_token" {
    description = "An API Token from Linode (personal access token)"
    default = "token-goes-here"
  }
```

Now when tf runs, it can access linode to do stuff.

<br>

## To Run Locally

Firstly download terraform and add it to your path variable.

https://www.terraform.io/downloads.html

<br>

## Initializing TF

This will install the linode provisioner, run the appropriate one for the environment you are working on at the time
\*\*If you have issues, remove -reconfigure

```bash
tf -chdir="./manifests" init -backend-config="../environments/foodyfood-prod/foodyfood-prod.backend.tfvars" -reconfigure
```

<br>

## tf plan

Running tf plan on a directory will print out all the things that tf is going to create or change, we also save the 'plan' to a tfplan file

```bash
tf -chdir="./manifests" plan -var-file="../environments/foodyfood-prod/foodyfood-prod.tfvars" -out="../environments/foodyfood-prod/tfplan"
```

<br>

## tf apply

Running tf apply will start creating infrastructure based on the contents of the tfplan file
_DOES NOT CONFIRM BEFORE IT RUNS, CAREFUL, HERE BE DRAGONS_

```bash
tf -chdir="./manifests" apply ../environments/foodyfood-prod/tfplan
OR
tf -chdir="./manifests" apply -var-file="../environments/foodyfood-prod/foodyfood-prod.tfvars"
```

<br>

## tf refresh

Fetch the current state of the 'real world', and update the tfstate file to match it, when you run a refresh, you then need to run an apply to put the refreshed values into the tfstate

```bash
terraform -chdir="./manifests" apply -refresh-only -auto-approve
```

<br>

## tf destroy

Running tf destroy will destroy the infra described in a certain backend file

```bash
tf -chdir="./manifests" destroy -var-file="../environments/foodyfood-prod/foodyfood-prod.tfvars"
```

## tf fmt

Will validate your code for formatting, your code will not pass the GitHub action if it doesn't pass tf fmt -check -recursive

Any file names that prinnt out mean there is something wrinig with them

Explicitely run tf fmt on each one to try fix them, for example

```bash
tf fmt ./modules/charts/versions.tf
tf fmt ./variables.tf
```
