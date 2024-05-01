# Bucket
resource "google_storage_bucket" "bucket" {
  name     = "storage-bucket-2251"
  location = "us-central1"
  storage_class = "STANDARD"
  uniform_bucket_level_access = false
  versioning {
    enabled = true
  } 
}

resource "google_storage_default_object_access_control" "object_read" {
  bucket = google_storage_bucket.bucket.name
  role   = "READER"
  entity = "allUsers"
}
