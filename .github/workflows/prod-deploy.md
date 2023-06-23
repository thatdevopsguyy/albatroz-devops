# Deploy to Production Workflow

This GitHub Actions workflow enables the deployment of an application to a production environment. It uses Docker Compose to manage the containers and deploys various images based on the specified versions.

## Workflow Trigger

The workflow is triggered manually using the `workflow_dispatch` event. When executing the workflow, you can provide input parameters to control the versions of different images used in the deployment.

### Input Parameters

- **generalVersion** (optional): Version for all images (used if specific version is not provided). Default: `latest`.
- **backendVersion** (optional): Version for the backend image. Default: `latest`.
- **frontendVersion** (optional): Version for the frontend image. Default: `latest`.
- **nginxVersion** (optional): Version for the nginx image. Default: `latest`.
- **nginxProxyVersion** (optional): Version for the nginx-proxy image. Default: `latest`.
- **letsencryptVersion** (optional): Version for the letsencrypt image. Default: `latest`.

## Environment Variables

The following environment variables are used in the workflow:

- **REGISTRY**: The Docker registry URL. Default: `albatrozcr.azurecr.io`.
- **IMAGE_NAME**: The name of the Docker image. Default: `albatroz`.

## Workflow Steps

1. **Checkout repository**: Checks out the repository where the deployment files are located.
2. **Install SSH key**: Installs the SSH key needed to establish a connection with the production server.
3. **Copy Docker Compose file to remote server**: Copies the `docker-compose.prod.yml` file to the remote production server using SCP.
4. **Deploy**: Executes the deployment commands on the remote server via SSH.

   - The deployment script sets environment variables for the different image versions based on the provided input parameters.
   - It performs a Docker login to the specified registry using the provided credentials.
   - The required Docker images are pulled based on the specified tags.
   - Finally, Docker Compose is used to start the production containers with the `docker-compose.prod.yml` file.

Please ensure that the necessary secrets and configurations are properly set in your GitHub repository for a successful deployment.

---
Please note that this workflow assumes you have a self-hosted runner configured to execute the deployment steps on the production server.

For more information on configuring and using GitHub Actions workflows, refer to the [GitHub Actions documentation](https://docs.github.com/actions).
