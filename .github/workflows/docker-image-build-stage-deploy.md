# Docker Image Build & Stage Deploy CI

This GitHub Actions workflow automates the build and deployment of Docker images for different components of the Albatroz application to a staging environment. The workflow is triggered on specific events and allows for manual execution with input parameters.

## Workflow Trigger

The workflow is triggered by the following events:
- `push`: Triggered when a push occurs on the `dev`, `stage`, `main`, or `master` branches.
- `pull_request`: Triggered when a pull request is opened or synchronized.
- `repository_dispatch`: Triggered by a custom repository dispatch event.
- `workflow_dispatch`: Manually triggered, allowing for input parameters to control the image to build.

### Input Parameters

The workflow can be manually triggered with the following input parameters:
- **image** (required): Specifies which image to build. Options include `all`, `backend_code`, `frontend_code`, `nginx`, `nginx-proxy`, or `letsencrypt`. The default value is `all`.

## Jobs

The workflow consists of the following jobs:

### Setup

This job runs on a self-hosted runner and performs the initial setup tasks. It checks out the repository, retrieves the semantic version, and logs in to the Azure Container Registry.

### Build Backend, Frontend, Nginx, Nginx Proxy, and LetsEncrypt

These jobs run on self-hosted runners and build and push the respective Docker images. The jobs are conditional based on the specified image or triggering events. They delete old images, build new ones, and push them to the Azure Container Registry.

### Deploy

This job runs on a self-hosted runner and deploys the application to the staging environment. It copies the `docker-compose.stage.yml` file to the remote server, sets environment variables, logs in to the container registry, pulls the necessary images, and starts the containers using Docker Compose.

Please ensure that the required secrets and configurations are properly set in your GitHub repository for a successful deployment.

---
For more information on configuring and using GitHub Actions workflows, refer to the [GitHub Actions documentation](https://docs.github.com/actions).
