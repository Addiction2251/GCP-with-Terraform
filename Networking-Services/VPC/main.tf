resource "google_compute_network" "vpc_network" {
  project = "experimentation1-415504"
  name                    = "vpc-network-1"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "vpc_subnetwork-public" {
    project ="experimentation1-415504"
    name = "public-subnetwork"
    region = "us-central1"

    network = google_compute_network.vpc_network.id
    ip_cidr_range = "10.0.0.0/24"
}

resource "google_compute_subnetwork" "vpc_subnetwork-private" {
    project ="experimentation1-415504"
    name = "private-subnetwork"
    region = "us-central1"

    network = google_compute_network.vpc_network.id
    ip_cidr_range = "10.0.1.0/24"
}