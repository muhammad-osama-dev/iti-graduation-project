resource "google_artifact_registry_repository" "my-repo" {
  location      = "us-east1"
  repository_id = var.repo_id
  description   = var.repo_desc
  format        = "DOCKER"

  docker_config {
    immutable_tags = false
  }
}


resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "tf-bucket" {
  name          = "${random_id.bucket_prefix.hex}-bucket-tfstate"
  force_destroy = false
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
  encryption {
    default_kms_key_name = google_kms_crypto_key.terraform_state_bucket.id
  }
}