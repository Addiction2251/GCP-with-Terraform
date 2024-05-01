

# Define the VPC resource
resource "google_compute_network" "vpc" {
  name = "my-vpc"
  auto_create_subnetworks = false
}

# Define Public Subnet
resource "google_compute_subnetwork" "public_subnet" {
  name          = "public-subnet"
  ip_cidr_range  = "10.0.1.0/24"
  region = "us-central1"
  network       = google_compute_network.vpc.name
  # Enable public IP for resources in this subnet
  private_ip_google_access = false
}

# Define Private Subnet
resource "google_compute_subnetwork" "private_subnet" {
  name          = "private-subnet"
  ip_cidr_range  = "10.0.2.0/24"
region = "us-central1"
  network       = google_compute_network.vpc.name
  # Keep private IP for resources in this subnet (default)
  private_ip_google_access = true
}

# Cloud NAT (for internet access in private subnet)
resource "google_compute_router" "nat_router" {
  name    = "nat-router"
  network = google_compute_network.vpc.name

#   # NAT configuration
#   nat_hairpin_mode = "ENABLED"  # Corrected attribute name

#   # Define an interface for the private subnet
#   interface {
#     name       = "private-subnet-interface"
#     subnetwork = google_compute_subnetwork.private_subnet.name
#   }

#   # Define an interface for the internet access
#   interface {
#     name       = "internet-interface"
#     network    = "intercloud-tier-1"  # GCP's pre-defined network for internet access
#   }
}

# Define a VM instance
resource "google_compute_instance" "vm_instance" {
  name         = "my-vm-instance"
  machine_type = "e2-micro"  # Choose an appropriate machine type

  # Configure boot disk
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"  # Choose a desired image
    }
  }

  # Networking configuration
  network_interface {
    network = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.public_subnet.name
  }
}
