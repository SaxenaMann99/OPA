provider "google" {
  credentials = file("/tmp/credentials.json")
  project     = "project-terraform-457305"
  region      = "asia-south2"
}

resource "google_storage_bucket" "example_bucket" {
  name     = "opa-test"
  location = "Asia"
  predefined_acl = "publicRead"
}

# Optional: Define bucket ACLs
resource "google_storage_bucket_acl" "example_bucket_acl" {
  bucket = google_storage_bucket.example_bucket.name
  role_entity = [
    "READER:allUsers", # This will trigger the OPA policy
  ]
}

# Optional: Define bucket access control
resource "google_storage_bucket_access_control" "example_bucket_access_control" {
  bucket = google_storage_bucket.example_bucket.name
  entity = "allUsers"
  role   = "READER" # This will trigger the OPA policy
}
