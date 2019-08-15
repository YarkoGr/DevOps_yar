provider "google" {
  credentials = file("test-terraform.json")
  project     = "devops-248910"
  region      = "europe-west3"
}

