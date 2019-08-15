resource "google_compute_firewall" "allow-http" {
  name    = "web-firewall"
  network = ""
  target_tags = ["mweb"]

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-ssh" {
  name    = "ssh-firewall"
  network = ""
   target_tags   = ["mdb", "mweb"]

  allow {
    protocol = "tcp"
    ports    = ["3306", "22"]
  }
  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}
