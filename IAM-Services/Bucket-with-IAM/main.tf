

# Define the GCS bucket resource
resource "google_storage_bucket" "my_bucket" {
  name     = "mybucket2251"
  location = "us-central1" # Update with desired location (see regions https://cloud.google.com/compute/docs/regions-zones)
}

# Define IAM policy for the bucket with admin role
resource "google_storage_bucket_iam_binding" "bind_service_account" {
  bucket = google_storage_bucket.my_bucket.name
  role    = "roles/storage.editor"  # Grant admin role
  members = ["user:randomidcreator@gmail.com"]
}