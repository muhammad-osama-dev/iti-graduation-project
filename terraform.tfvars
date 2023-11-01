project_id = "halogen-data-401020"
region1 = "us-central1"
region2 = "us-east1"
vpc_name = "project"
gke_ip_cidr_range = "10.10.10.0/24"
private_ip_cidr_range = "10.10.20.0/24"


# VM

vm_name = "my-private-instance"
vm_type = "e2-micro"
vm_zone = "us-east1-b"
vm_image = "debian-cloud/debian-10"
labels_tags = [ "private-subnet" ]


# GKE
gke_name = "gke-cluster"

# Storage

repo_id = "private-vm-repo"
repo_desc = "repo for the private vm"
