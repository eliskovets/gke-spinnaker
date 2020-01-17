# Terraform configuration for installing spinnaker on GKE 

### Prerequisite 

* Following tools needs to be installed in local machine and available via `PATH` 
    * [gcloud SDK](https://cloud.google.com/sdk/install)
    * [kubectl](https://cloud.google.com/kubernetes-engine/docs/quickstart) (`gcloud components install kubectl`)
    * [terraform](https://www.terraform.io/intro/getting-started/install.html)
    * [helm CLI](https://docs.helm.sh/using_helm/#installing-helm)
    
## Installation steps

1.  Create a project in the [Google Cloud Console](https://console.cloud.google.com/)
    ```
    export PROJECT_ID="spinnaker-$(date +'%s')"
    gcloud projects create $PROJECT_ID --name Spinnaker --set-as-default
    ```
1. Enable billing for your new project from the page: https://console.cloud.google.com/m/billing/projects/${PROJECT_ID}
1.  `terraform` uses [Service Usage API](https://github.com/terraform-providers/terraform-provider-google/blob/master/CHANGELOG.md#1130-may-24-2018),
    this API needs to be enabled manually
    https://console.developers.google.com/apis/library/serviceusage.googleapis.com

1.  Create service account for `terraform` 
    ```
    gcloud iam service-accounts create terraform --display-name "terraform"
    gcloud iam service-accounts keys create account.json --iam-account terraform@$(gcloud info --format='value(config.project)').iam.gserviceaccount.com
    ```
    Above command will download the key and store it in `account.json` file
    
1.  Grant owner role to terraform service account    
    ```
    gcloud projects add-iam-policy-binding $(gcloud info --format='value(config.project)') --member serviceAccount:terraform@$(gcloud info --format='value(config.project)').iam.gserviceaccount.com --role roles/owner
    ```