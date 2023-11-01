resource "google_artifact_registry_repository" "my-repo" {
  location      = "us-east1"
  repository_id = var.repo_id
  description   = var.repo_desc
  format        = "DOCKER"

  docker_config {
    immutable_tags = false
  }
}
