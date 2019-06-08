variable "do_token" {}

variable "region" {
  default = "SGP1"
}

variable "image" {
  default = "ubuntu-18-04-x64"
}

variable "no_clusters" {
  default = 3
}

variable "no_workers_per_cluster" {
  default = 2
}

provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_ssh_key" "default" {
  name       = "k8s workshop key"
  public_key = "${file("/Users/heytitle/.ssh/id_k8s_rsa.pub")}"
}


resource "digitalocean_droplet" "master" {
  count = "${var.no_clusters}"
  size = "s-2vcpu-2gb"
  image = "${var.image}"
  name = "k8s-workshop-cluster-${count.index+1}-master"
  region = "${var.region}"
  ssh_keys = ["${digitalocean_ssh_key.default.fingerprint}"]
}

resource "digitalocean_droplet" "worker1" {
  count = "${var.no_clusters}"
  size = "s-1vcpu-2gb"
  image = "${var.image}"
  name = "k8s-workshop-cluster-${count.index+1}-worker-1"
  region = "${var.region}"
  ssh_keys = ["${digitalocean_ssh_key.default.fingerprint}"]
}

resource "digitalocean_droplet" "worker2" {
  count = "${var.no_clusters}"
  size = "s-1vcpu-2gb"
  image = "${var.image}"
  name = "k8s-workshop-cluster-${count.index+1}-worker-2"
  region = "${var.region}"
  ssh_keys = ["${digitalocean_ssh_key.default.fingerprint}"]
}

output "master-ips" { 
  value = ["${digitalocean_droplet.master.*.ipv4_address}"]
}

output "worker1-ips" { 
  value = ["${digitalocean_droplet.worker1.*.ipv4_address}"]
}

output "worker2-ips" { 
  value = ["${digitalocean_droplet.worker2.*.ipv4_address}"]
}