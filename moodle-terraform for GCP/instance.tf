resource "google_compute_instance" "mdb" {
  name         = "mdb"
  machine_type = "f1-micro"
  zone         = "europe-west3-a"
  tags         = ["mdb"]

  boot_disk {
    initialize_params {
      image = "centos-7-v20190729"
    }
  }

  network_interface {
    network            = "default"
    subnetwork         = ""
    subnetwork_project = ""
    network_ip         = ""
    
    access_config {
            nat_ip = ""
    }
  }

  metadata = {
    ssh-keys = "yarko:${file("~/.ssh/id_rsa.pub")}"
  }
}



resource "google_compute_instance" "mweb" {
  name         = "mweb"
  machine_type = "f1-micro"
  zone         = "europe-west3-a"
  tags         = ["mweb"]

  boot_disk {
    initialize_params {
      image = "centos-7-v20190729"
    }
  }

  network_interface {
    network            = "default"
    subnetwork         = ""
    subnetwork_project = ""
    network_ip         = ""
    
    access_config {
            nat_ip = ""
    }
  }
  metadata = {
    ssh-keys = "yarko:${file("~/.ssh/id_rsa.pub")}"
  }
}