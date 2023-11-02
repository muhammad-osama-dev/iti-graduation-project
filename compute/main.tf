data "template_file" "startup_script" {
  template = file("./compute/startup-private-vm.sh")

  vars = {
    VAR1_project_id = var.project_id
    VAR2_repo_id = var.repo_id
    VAR4_cluster_name = var.gke_name
    VAR3_cluster_region = var.region1

  }
}


resource "google_compute_instance" "my-private-vm" {
  name         = var.vm_name
  machine_type = var.vm_type
  zone         = var.vm_zone

  tags = var.labels_tags
  depends_on = [ google_container_node_pool.privatecluster-node-pool ]
  boot_disk {
     initialize_params {
      image = var.vm_image
      size = 10
    }
  }

  
  network_interface {
    network = var.vpc_name
    subnetwork = var.private_subnet_name
    
  }

   metadata = {
    "sa_key" = var.sa_key

  }

  metadata_startup_script = data.template_file.startup_script.rendered

  # metadata_startup_script = file("./compute/startup-private-vm.sh")

  service_account {
    email  = var.sa_email
    scopes = ["cloud-platform"]
  }
}






###################################### GKE ###############################################

resource "google_service_account" "kubernetes" {
  account_id = "kubernetes"
}

resource "google_project_iam_member" "artifact_registry_reader" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.kubernetes.email}"
}


resource "google_container_cluster" "privatecluster"{
  name     = var.gke_name
  network = var.vpc_name
  subnetwork = var.gke_subnet_name
  location = var.region1
  deletion_protection = false  # Set this to false



  remove_default_node_pool = true
  initial_node_count       = 1

  master_authorized_networks_config {
    cidr_blocks {
        cidr_block = var.private_ip_cidr_range
        display_name = "vm"
    }
    cidr_blocks {
      cidr_block = "34.132.20.209/32"
      display_name = "my-ip"
    }

    cidr_blocks {
      cidr_block = "41.233.209.135/32"
      display_name = "my-home-ip"
    }
  }
  private_cluster_config {
    enable_private_nodes = true
    enable_private_endpoint = false
    master_ipv4_cidr_block = "172.16.0.0/28"
  }
   ip_allocation_policy {
  }
  node_config {
    preemptible  = true
    machine_type = "e2-small"
    disk_type    = "pd-standard"
    # disk_type    = var.workern_disktype
    disk_size_gb = 15
    # image_type   = var.workern_imagetype
    service_account = google_service_account.kubernetes.email
    oauth_scopes    = [ 
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_container_node_pool" "privatecluster-node-pool" {
  name       = "node-pool"
  cluster    = google_container_cluster.privatecluster.name
  node_count = 1
  location   = "us-central1"  
 
  node_config {
    preemptible  = true
    machine_type = "e2-small"
    disk_type    = "pd-standard"
    # disk_type    = var.workern_disktype
    disk_size_gb = 15
    # image_type   = var.workern_imagetype
    service_account = google_service_account.kubernetes.email
    oauth_scopes    = [ 
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  node_locations = [
    "${var.region1}-a",
    "${var.region1}-b",
    "${var.region1}-c"
  ]
}