# CI/CD with Terraform, Jenkins, and GKE README

## Overview

This repository demonstrates a two-pipeline CI/CD setup for deploying a nodejs application with mongodb on Google Kubernetes Engine (GKE). The infrastructure is managed using Terraform, and the application deployment is automated through Jenkins.

## Prerequisites

Before you can set up the CI/CD system, make sure you have the following prerequisites:

- [Google Cloud Platform (GCP) Account](https://cloud.google.com/)
- [Terraform](https://www.terraform.io/) installed
- [Google Cloud SDK](https://cloud.google.com/sdk) installed
- [Jenkins](https://www.jenkins.io/) installed and configured
- Your application source code and Dockerfile

## Infrastructure Pipeline (1st Pipeline)

### Terraform Configuration

1. fork the repo and edit the variables for your specification.

2. Configure a remote backend for Terraform (e.g., Google Cloud Storage).

3. Set up a GCP project and enable the necessary APIs, including the Kubernetes Engine API.

4. Create a service account and grant it the necessary permissions (e.g., roles/editor) for terraform.

5. Create a Google Cloud Storage bucket for storing Terraform state files.

6. update the backend.tf to point to your new bucket. 

### Jenkins Pipeline

1. Create a Jenkins pipeline job for the Infrastructure Pipeline.

2. configure the pipeline to pull from your forked repo. (configure git credintials if you need to)

3. Configure a post-build action in your Jenkins job to trigger the 2nd Application Pipeline when the Infrastructure Pipeline succeeds.

## Application Pipeline (2nd Pipeline)

### Jenkins Pipeline 

1. Create a separate Jenkins pipeline job for your Application Pipeline (refer to https://github.com/muhammad-osama-dev/simple-node-app).

2. have the kubernetes manifests on your machine.

3. Customize the Jenkinsfile to suit your deployment requirements and change the path for the kubernetes files.

### Triggering the Application Pipeline

- Manually start the Application Pipeline when you're ready to deploy the application.

- Configure your Jenkins job for the Application Pipeline to be triggered automatically when the Infrastructure Pipeline completes successfully.


## Troubleshooting

- If you encounter any issues during setup or deployment, consult the Jenkins and Terraform documentation for troubleshooting guidance.

## Security

Please handle sensitive information such as service account keys and credentials securely. Do not store them in your code repository.

## Cleanup

build with parameters and destroy infrastructure pipeline.

## Customization

You can customize the pipelines and scripts to fit your specific project requirements. Feel free to modify and extend the Jenkinsfiles and Terraform configurations as needed.

## License

This project is licensed under the [Your License] - see the [LICENSE.md](LICENSE.md) file for details.

## Contact Information

If you have questions, need assistance, or want to report issues, please feel free to contact [Your Contact Information].

Happy DevOpsing!