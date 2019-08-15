resource "null_resource" "db_prov" {
  
  depends_on = [google_compute_instance.mdb]


  connection {
    host        = "${google_compute_instance.mdb.network_interface.0.access_config.0.nat_ip}"
    type        = "ssh"
    user        = "yarko"
    agent       = false
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "file" {
    source      = "mdb.sh"
    destination = "/tmp/mdb.sh"   
 } 
  
  provisioner "remote-exec" {

    inline = [
      "sudo chmod +x /tmp/mdb.sh",
      "sudo /bin/bash /tmp/mdb.sh ${google_compute_instance.mweb.network_interface.0.network_ip}"
    ]
  }
}

resource "null_resource" "web_prov" {
 
  depends_on = [null_resource.db_prov]


  connection {
    host        = "${google_compute_instance.mweb.network_interface.0.access_config.0.nat_ip}"
    type        = "ssh"
    user        = "yarko"
    agent       = false
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "file" {
    source      = "mweb.sh"
    destination = "/tmp/mweb.sh"   
 } 

  provisioner "remote-exec" {
  
    inline = [
      "sudo chmod +x /tmp/mweb.sh",
      "sudo /bin/bash /tmp/mweb.sh ${google_compute_instance.mweb.network_interface.0.access_config.0.nat_ip} ${google_compute_instance.mdb.network_interface.0.network_ip}"
    ]
  }
}