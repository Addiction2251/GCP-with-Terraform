# Create a VPC network
resource "google_compute_network" "vpc_network" {
  name = "my-vpc-network"
  auto_create_subnetworks = false
}

# Create a public subnet
resource "google_compute_subnetwork" "public_subnet" {
  name          = "public-subnet"
  region         = "us-central1"
  network       = google_compute_network.vpc_network.self_link
  ip_cidr_range = "10.1.0.0/24"
}

# # Create a route for internet access
# resource "google_compute_route" "public_route" {
#   name       = "internet-route"
#   network    = google_compute_subnetwork.public_subnet.network
#   dest_range = "0.0.0.0/0"
#   next_hop_gateway = google_compute_address.internet_gateway.address
# }

# Create an internet gateway for the VPC
resource "google_compute_address" "internet_gateway" {
  name = "internet-gateway"
  address_type = "EXTERNAL"
  region        = google_compute_subnetwork.public_subnet.region
}

# Define firewall rules for the subnet
resource "google_compute_firewall" "allow_http" {
  name       = "allow-http"
  network    = google_compute_subnetwork.public_subnet.network
  description = "Allow inbound HTTP traffic"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_ssh" {
  name       = "allow-ssh"
  network    = google_compute_subnetwork.public_subnet.network
  description = "Allow inbound SSH traffic"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}