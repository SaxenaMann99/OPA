provider "google" {
  credentials = file("/tmp/key.json")
  project     = "project-terraform-457305"
  region      = "asia-south2"
}

resource "google_compute_instance" "default" {
  name         = "my-instance"
  machine_type = "f1-micro"
  zone         = "asia-south2-a"

  tags = ["production", "team-name"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
    }
  }
}

resource "google_storage_bucket" "default" {
  name     = "my-bucket"
  location = "Asia"

  versioning {
    enabled = true
  }

  labels = {
    environment = "production"
    owner       = "team-name"
  }
}
