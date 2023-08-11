# Introduction

ITAU Subscription Lifecycle project provides application and required infrastructure code to create below scenarios.

- **Azure Governance** for custom azure policies, diagnostic policies and RBAC.
- **Configuration Management** for automation capabilities and deployment of Azure Services, Netorking,  Storage, AKS etc.
- **Resiliency** for High Availability (HA), Disaster Recovery (DR) and Data Protection (backup).
- **Update management center** for managing and govern updates for virtual machines. Monitor Windows and Linux update compliance across deployments in Azure.
- **Cost Management** for analysis, monitor and optimization of Azure costs.

# Pre-requisites

- An active Azure subscription with either owner access or contributor with user access administrator permission.
- Contributor permission on GITHUB project.
- A service principal to use its application ID , secret and Object ID from enterprise application.

# Repository Content


| File/folder                                 | Description                                |
|---------------------------------------------|--------------------------------------------|
| `.github\workflows\feature.yml`               | CI Workflow trigger       |
| `.github\workflows\ci.yml`| Azure Foundation CI Workflow         |
| `.github\workflows\develop.yml`| Foundation Subscription develop branch workflow        |
| `.github\workflows\cd.yml`                                 | Azure Foundation CD Workflow                          |
| `infra\env\dev`                                 | Terragrunt configuration location for DEV Resources                              |
| `infra\env\dev\env.hcl`                                   | Environment Variables for DEV                  |
| `.infra\env\prod`                                | Terragrunt configuration location for PROD Resources       |
| `infra\env\prod\env.hcl`         | Environment Variables for PROD                                      |
| `infra\modules` | Environment specific variable files.       |
| `infra\env\{environment}\{resource}\terragrunt.hcl`   | Terragrunt configuration file for resources |
| `infra\terragrunt.hcl` | Base Terragrunt configuration       |
| `scripts\create-tf-backend-azure.sh` | Backend configuration script              |
| `.gitignore` | Define what to ignore at commit time    |
| `CONTRIBUTING.MD`                       | Guidelines for contributing                       |
| `LICENSE`                                 | The License                           |
| `README.md`                              | Read-me file                            |

# Contribution Workflow

Here’s how it generally works:
- Create a feature branch from develop branch.
- Update the feature branch with your changes.
- Make commits to your feature branch.
- The workflow will get triggered and open a Pull Request.
- Discuss with the team, and optionally continue committing.
- The repo reviewers will review and merges or closes the Pull Request.
- Make sure any new changes to the develop branch are pulled in to your feature branch.