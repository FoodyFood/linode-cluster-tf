# Setting up terraform

## Fetch TF

Firstly download it and add it to your path variable.

https://www.terraform.io/downloads.html

<br>

## Create a linode token (or get one from the onenote)

Log into Linode, and create a personal access token

https://cloud.linode.com/profile/tokens
<br>

## Adding the token to GitHub for GitHub workflows to build your cluster for you

![github-secret](/docs/github-secret.PNG)

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


## Initializing TF

This will install the linode provisioner, run the appropriate one for the environment you are working on at the time
\*\*If you have issues, remove -reconfigure

```bash
tf -chdir="./manifests" init -backend-config="../../environments/foodyfood-prod/.backend.tfvars" -reconfigure
```

<br>

## tf plan

Running tf plan on a directory will print out all the things that tf is going to create or change, we also save the 'plan' to a tfplan file

```bash
tf -chdir="./manifests" plan -var-file="../../environments/foodyfood-prod/.tfvars" -out="../../environments/foodyfood-prod/tfplan"
```

<br>

## tf apply

Running tf apply will start creating infrastructure based on the contents of the tfplan file
_DOES NOT CONFIRM BEFORE IT RUNS, CAREFUL, HERE BE DRAGONS_

```bash
tf -chdir="./manifests" apply ../../environments/foodyfood-prod/tfplan
OR
tf -chdir="./manifests" apply -var-file="../../environments/foodyfood-prod/.tfvars"
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
tf -chdir="./manifests" destroy -var-file="../../environments/foodyfood-prod/.tfvars"
```

## tf fmt

Will validate your code for formatting, your code will not pass the GitHub action if it doesn't pass tf fmt -check -recursive

Any file names that prinnt out mean there is something wrinig with them

Explicitely run tf fmt on each one to try fix them, for example

```bash
tf fmt ./modules/charts/versions.tf
tf fmt ./variables.tf
```
