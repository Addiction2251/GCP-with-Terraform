provider "google" {
    #path for GCP service account credentials
    credentials = "key.json"
    # GCP project ID
    project     = "experimentation1-415504"
    # Any region of your choice
    region      = "us-central1"
    # Any zone of your choice      
    zone        = "us-central1-a"
  }

