resource "google_artifact_registry_repository" "my-repo" {
  location      = "us-east1"
  repository_id = var.repo_id
  description   = var.repo_desc
  format        = "DOCKER"

  docker_config {
    immutable_tags = false
  }
}


resource "google_storage_bucket" "terraform-bucket-for-state" {
  name                        = "bucket-dev"
  location                    = "US"
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
  labels = {
    "environment" = "mo"
  }
}