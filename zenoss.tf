variable "region_zone" {
  default = "us-west1-a"
}

variable "the_count" {
  default = "1"
}

resource "google_compute_firewall" "default" {
  name = "zenoss-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["22","80","443","4979"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["zenoss"]
}

resource "google_compute_disk" "zenoss-disk" {
  count = "${var.the_count}"
  name = "zenoss-disk-${count.index}"
  size = 40
  zone = "${var.region_zone}"
}

resource "google_compute_instance" "default" {
  count = "${var.the_count}"
  name = "zenoss${count.index}"
  machine_type = "n1-highmem-4"
  zone = "${var.region_zone}"
  tags = ["zenoss"]
  depends_on = ["google_compute_disk.zenoss-disk"]

  boot_disk {
    initialize_params {
      image = "centos-7-v20180507"
    }
  }

  attached_disk {
    source = "zenoss-disk-${count.index}"
    device_name = "data"
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}

output "instance_id" {
 value = "${google_compute_instance.default.*.self_link}"
}

output "nat_ip" {
 value = "${google_compute_instance.default.*.network_interface.0.access_config.0.nat_ip}"
}
