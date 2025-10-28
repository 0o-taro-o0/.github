# .github-private

Private default health files and development container configurations.

## Contents

- **Issue Templates**: Standard issue templates for bug reports and feature requests
- **Pull Request Template**: Standard PR template
- **Devcontainer Configurations**: Reusable devcontainer setups with features support

## Devcontainer Configurations

This repository provides modular devcontainer configurations using [devcontainer features](https://containers.dev/features). 

See [.devcontainer/README.md](.devcontainer/README.md) for detailed documentation and [.devcontainer/USAGE.md](.devcontainer/USAGE.md) for usage examples.

### Available Configurations

- **base**: Minimal UBI9 base image with essential tools
- **terraform**: Terraform development environment
- **terraform-aws**: Terraform + AWS CLI environment
- **python-aws**: Python + AWS CLI environment
- **fullstack**: Full-stack development (Node.js + Python + Docker)
- **simple-example**: Minimal template for quick customization

### Quick Start

```bash
# Copy a configuration to your project
cp -r .devcontainer/terraform-aws /path/to/your/project/.devcontainer

# Or use directly via URL in your devcontainer.json
{
  "image": "registry.access.redhat.com/ubi9/ubi:latest",
  "features": {
    "ghcr.io/devcontainers/features/terraform:1": {},
    "ghcr.io/devcontainers/features/aws-cli:1": {}
  }
}
```
