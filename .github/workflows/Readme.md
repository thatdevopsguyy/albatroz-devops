## Terraform Unit Tests (tf-unit-tests.yml)
This  GitHub Actions workflow file named terraform-unit-tests.yml that sets up a workflow for running unit tests on Terraform configurations. The workflow validates and formats the Terraform files to ensure adherence to a canonical format.

# Usage

* To use this workflow, follow the steps below:

* Create a .github/workflows directory in your repository if it doesn't already exist.
* Create a new file named terraform-unit-tests.yml in the .github/workflows directory.
* Copy the contents of the workflow file into terraform-unit-tests.yml.
* Customize the environment variables (TF_VAR_) in the workflow to match your specific configuration. The variables specify values such as location, resource group name, VM sizes, container names, etc. You can update these variables according to your requirements.
* If you have any secrets that need to be passed as environment variables, such as the admin password or SQL server admin password, make sure to set them as GitHub Secrets in your repository settings and reference them using ${{ secrets.SECRET_NAME }} syntax in the workflow file.
* Commit and push the changes to your repository.

The workflow will be triggered automatically on every push to the repository or manually through the GitHub Actions UI.

# Workflow Steps
The workflow consists of the following steps:

- `Checkout`: Checks out the repository to the GitHub Actions runner.
- `Setup Terraform`: Installs the latest version of the Terraform CLI and configures the Terraform CLI configuration file with a Terraform Cloud user API token.
- `Terraform Init`: Initializes a new or existing Terraform working directory by creating initial files, loading any remote state, and downloading modules.
- `Terraform Validate`: Validates the Terraform files to ensure they have correct syntax and structure.
- `Terraform Format`: Checks that all Terraform configuration files adhere to a canonical format.

The workflow performs basic validation and formatting checks to ensure the Terraform files are well-formed and adhere to recommended conventions.

## Terraform Plan/Apply (tf-plan-apply.yml)

This GitHub Actions workflow file named terraform-plan-apply.yml that sets up a workflow for planning and applying Terraform configurations. The workflow includes the following steps:

# Workflow Triggers
The workflow is triggered on the following events:

- `Manual dispatch`: The workflow can be manually triggered through the GitHub Actions UI.
- `Push`: The workflow is triggered when there are push events on the main branch.
- `Pull Request`: The workflow is triggered when there are pull request events on the main branch.

# Environment Variables

The workflow uses several environment variables to configure the Terraform Azure provider and set up OIDC authentication. These variables include the Azure client ID, client secret, subscription ID, and tenant ID. Make sure to set these variables as GitHub Secrets in your repository settings. Other variables are also set to configure specific Terraform resources and settings.

# Workflow Steps

*Terraform Plan*

The `terraform-plan` job performs the following steps:

- `Checkout`: Checks out the repository to the GitHub Actions runner.
- `Setup Terraform`: Installs the latest version of the Terraform CLI.
- `Terraform Init`: Initializes a new or existing Terraform working directory by creating initial files, loading any remote state, and downloading modules.
- `Terraform Format`: Checks that all Terraform configuration files adhere to a canonical format.
- `Terraform Plan`: Generates an execution plan for Terraform and stores it in a file named tfplan. The plan is detailed and includes no color. The exit code of the terraform plan command is captured and exported as an environment variable for further use.
- `Publish Terraform Plan`: Uploads the tfplan file as an artifact.
- `Create String Output`: Retrieves the Terraform plan output as a string and formats it for display in the GitHub Actions task summary.
- `Publish Terraform Plan to Task Summary`: Publishes the Terraform plan output to the GitHub Actions task summary.
- `Push Terraform Output to PR`: If the workflow is triggered by a pull request event, pushes the Terraform plan output as a comment to the corresponding pull request.

*Terraform Apply*

The `terraform-apply` job is conditional and only runs if the terraform-plan job exit code is 2, indicating that there are pending changes. This job performs the following steps:

- `Checkout`: Checks out the repository to the GitHub Actions runner.
- `Setup Terraform`: Installs the latest version of the Terraform CLI.
- `Terraform Init`: Initializes a new or existing Terraform working directory by creating initial files, loading any remote state, and downloading modules.
Download Terraform Plan: Downloads the tfplan file artifact from the previous job.
- `Terraform Apply`: Applies the saved Terraform plan using the terraform apply command with the -auto-approve flag.

# Usage

To use this workflow, follow the steps below:

* Create a .github/workflows directory in your repository if it doesn't already exist.
* Create a new file named terraform-plan-apply.yml in the .github/workflows directory.
* Copy the contents of the workflow file into terraform-plan-apply.yml.
Set the required environment variables as GitHub Secrets in your repository settings.
* Commit and push the changes to your repository.
* The workflow will be triggered automatically based on the defined events and conditions.

## Terraform Destroy

This GitHub Actions workflow file named terraform-destroy.yml that sets up a workflow for destroying Terraform resources. The workflow is manually triggered from the Actions tab.

# Environment Variables
The workflow uses several environment variables to configure the Terraform Azure provider and set up OIDC authentication. These variables include the Azure client ID, client secret, subscription ID, and tenant ID. Make sure to set these variables as GitHub Secrets in your repository settings. Other variables are also set to configure specific Terraform resources and settings.

# Workflow Steps

The `terraform-destroy` job performs the following steps:

- `Checkout`: Checks out the repository to the GitHub Actions runner.
- `Setup Terraform`: Installs the latest version of the Terraform CLI.
- `Terraform Init`: Initializes a new or existing Terraform working directory by creating initial files, loading any remote state, and downloading modules.
- `Terraform Destroy`: Destroys the Terraform resources using the terraform destroy command with the -auto-approve flag. This step automatically approves the destruction of resources without requiring user confirmation.

# Usage

To use this workflow, follow the steps below:

* Create a .github/workflows directory in your repository if it doesn't already exist.
* Create a new file named terraform-destroy.yml in the .github/workflows directory.
* Copy the contents of the workflow file into terraform-destroy.yml.
* Set the required environment variables as GitHub Secrets in your repository settings.
* Commit and push the changes to your repository.

To trigger the workflow, go to the Actions tab in your repository, select the "Terraform Destroy" workflow, and manually trigger it from the UI.

# Caution

The `terraform destroy` command is destructive and permanently deletes resources. Use it with caution, as it cannot be undone. Make sure to double-check that you are targeting the correct resources and take appropriate backups before executing the workflow.

