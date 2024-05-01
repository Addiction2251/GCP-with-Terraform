terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.44.1"
    }
   
  }
}

  provider "google"{
    project = "experimentation1-415504"
    region = "us-central1"
    zone = "us-central1-a"
    credentials = "key.json"
  }
