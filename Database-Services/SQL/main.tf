resource "google_sql_database_instance" "instance" {
  name             = "my-database-instance"
  region           = "us-central1"
  database_version = "POSTGRES_14"
  settings {
    tier = "db-g1-small"
  }

  deletion_protection  = "true"
}