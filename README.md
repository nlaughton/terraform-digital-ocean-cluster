# Terraform DigitalOcean Cluster
This repository contains a set of Terraform files that set up an environemnt in DigitalOcean containing:
* Kubernetes cluster
* PostgreSQL cluster
* Cert Manager with Let's Encrypt

## Set up a DigitalOcean Account
Set up a DigitalOcean account.
You can create a separate team for each cluster to keep the hosting charges separate.
Go to API on the left nav and set up a personal access token named Terraform.
Store the access token value in a secure place - it will be used in later steps. 

## Register a Domain
Register a domain (myapp.com for example).
Add the domain to your DigitalOcean team and connect it to the DigitalOcean nameservers using [DigitalOcean's instructions](https://docs.digitalocean.com/products/networking/dns/how-to/add-domains/).
Be sure to use a tool like [DNS Propagation Checker](https://www.whatsmydns.net/) to verify that the nameserver change have propagated before you try to do the first run.

## Set up a Terraform Cloud Account
Set up a Terraform Cloud account (the free plan is sufficient). A single account can be used for many applications.

## Create a Terraform Workspace
If you have just created your account and are at the "Welcome to Terraform Cloud" page, select the "Start from scratch" option. Create a new organization if prompted to do so ("my-company" or similar). This will navigate you to the create workspace page.

Create a new workspace as follows:

* Select Version control workflow
* Select GitHub (click Connect to a different VCS if you don't see GitHub)
* Select the apexdesigner organization (add it if it is not there)
* Select the terraform-digital-ocean-cluster repository
* Set the workspace name to your domain name + cluster (myapp-com-cluster for example)
* Select the default project
* Click the Create workspace button

## Configure the Terraform Variables
Follow the instructions to fill in the variables for the workspace and click Save variables.
* Use the Digital Ocean access token from the first step above

## Start a Run
Click the Start a new plan button to start the first run. The run will be done in two phases: plan and apply. After plan completes successfully, it will show the list of resources that apply will create. Click Confirm and Apply to start the apply phase.

## Verify the Setup
When the run is complete, you should be able to access the echo subdomain ("echo.myapp.com" for example). You may see a privacy error while Let's Encrypt issues the SSL cert. That can take up to an hour in some cases.

## Create a Terraform Project (Optional)
If you want you can create a project to organize your workspaces.

## What's Next?
If your app uses [Auth0](https://auth0.com) for authentication, you can configure that using [these instructions](https://github.com/apexdesigner/terraform-digital-ocean-auth0).
