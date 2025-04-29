provider "google" {
  credentials = file("/tmp/key.json")
  project     = "project-terraform-457305"
  region      = "asia-south2"
}

resource "google_compute_instance" "vm_instance" {
  name         = "vm-instance"
  machine_type = "e2-micro"
  zone         = "asia-south2-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
  }
}

resource "google_storage_bucket" "bucket" {
  name     = "my-unique-bucket-name"
  location = "US"
}
