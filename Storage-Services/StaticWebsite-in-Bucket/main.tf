# Bucket to store website
resource "google_storage_bucket" "website" {
  provider = google
  name     = "static-website-2251"
  location = "us-central1"
}

# Make new objects public
resource "google_storage_default_object_access_control" "website_read" {
  bucket = google_storage_bucket.website.name
  role   = "READER"
  entity = "allUsers"
}

#Uploading the Static website pages to the bucket.
#------------------------------------------------------

resource "google_storage_bucket_object" "static-website" {
  name   = "index"
  source = "index.html"
  content_type = "text/html"
  bucket = google_storage_bucket.website.name
}