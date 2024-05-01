resource "google_compute_network" "vpc_network" {
  name = "terraform-vpc-network"
}

output "VPC_Info" {
  value = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "vpc_network_tf_subnet" {
  name          = "my-subnetwork"
  ip_cidr_range = "10.0.0.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}

output "subnet_info" {
  value = google_compute_subnetwork.vpc_network_tf_subnet.name
}

resource "google_compute_address" "vpc_network_tf_subnet_internal_address" {
  name         = "my-static-internal-address"
  subnetwork   = google_compute_subnetwork.vpc_network_tf_subnet.self_link
  address_type = "INTERNAL"
  region       = "us-central1"
}

output "vpc_network_iip_info" {
  value = google_compute_address.vpc_network_tf_subnet_internal_address.address
}

resource "google_compute_address" "vpc_network_tf_subnet_external_address" {
  name         = "my-static-external-address"
  address_type = "EXTERNAL"
  region       = "us-central1"
}

output "vpc_network_eip_info" {
  value = google_compute_address.vpc_network_tf_subnet_external_address.address
}

resource "google_compute_instance" "tf_vm_instance" {
  name         = "tf-vm-instance"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"
  boot_disk {
  initialize_params {
     image = "debian-cloud/debian-11"
    }
  }

   network_interface {
    network = "projects/green-campaign-394213/global/networks/terraform-vpc-network"
    subnetwork_project = "green-campaign-394213"
    subnetwork = google_compute_subnetwork.vpc_network_tf_subnet.id
    network_ip = google_compute_address.vpc_network_tf_subnet_internal_address.address

    access_config {
      nat_ip = google_compute_address.vpc_network_tf_subnet_external_address.address
    }
  }
}

output "vm_name" {
  value = google_compute_instance.tf_vm_instance.name
}
