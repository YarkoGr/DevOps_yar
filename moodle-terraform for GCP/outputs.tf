output "mdb_external_ip" {
  value = "${google_compute_instance.mdb.network_interface.0.access_config.0.nat_ip}"
}

output "mweb_external_ip" {
  value = "${google_compute_instance.mweb.network_interface.0.access_config.0.nat_ip}"
}

output "mdb_internal_ip" {
  value = "${google_compute_instance.mdb.network_interface.0.network_ip}"
}

output "mweb_internal_ip" {
  value = "${google_compute_instance.mweb.network_interface.0.network_ip}"
}
