# Install GitHub Actions runner
# Create a folder
RUNNER_VERSION="2.304.0"

mkdir actions-runner && cd actions-runner

# Download the specific runner package
echo "Downloading GitHub Actions runner..."
curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Extract the runner package
echo "Extracting runner package..."
tar xzf actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Configure Runner
# Prompt for repository URL
read -p "Enter the GitHub repository URL: " REPO_URL

# Prompt for token
read -p "Enter the token: " TOKEN

# Install GitHub Actions runner
echo "Installing GitHub Actions runner..."
./config.sh --url "$REPO_URL" --token "$TOKEN" --unattended

# Create a service to keep the runner running
echo "Creating service..."
sudo ./svc.sh install

# Start the service
echo "Starting service..."
sudo ./svc.sh start

# Status of the service
echo "Checking status of the service..."
sudo ./svc.sh status
