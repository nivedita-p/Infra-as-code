resource "google_compute_network" "default" {
  name                    = "${var.network_name}"
  auto_create_subnetworks = "false"
  project                 ="${var.project}"
}

resource "google_compute_subnetwork" "default" {
  name                     = "${var.network_name}"
  ip_cidr_range            = "10.127.0.0/20"
  network                  = "${google_compute_network.default.self_link}"
  region                   = "${var.region}"
  project                 ="${var.project}"
  private_ip_google_access = true
}

resource "google_compute_backend_service" "mig-lb" {
  name        = "mig-lb"
  project     = "${var.project}"
  protocol    = "HTTP"
  timeout_sec = 10
  enable_cdn  = false

  backend {
    group = "${module.managed-webserver-group.region_instance_group}"
  }

  health_checks = ["${module.managed-webserver-group.google_compute_health_check.mig-health-check.self_link}"]
}

data "template_file" "startup-script" {
  template = "${file("${format("%s/startup.sh.tpl", path.module)}")}"
}

data "google_compute_zones" "available" {
  region = "${var.region}"
  project= "${var.project}"
}

module "managed-webserver-group" {
  source                    = "github.com/GoogleCloudPlatform/terraform-google-managed-instance-group.git"
  region                    = "${var.region}"
  distribution_policy_zones = ["${data.google_compute_zones.available.names}"]
  zonal                     = false
  name                      = "${var.network_name}"
  target_tags               = ["${var.network_name}"]
  service_port              = 80
  service_port_name         = "http"
  startup_script            = "${data.template_file.startup-script.rendered}"
  wait_for_instances        = true
  http_health_check         = true
  autoscaling               = true
  autoscaling_cpu = [{
    target = 0.8
  }]
  size                      = 3
  min_replicas              = 3
  max_replicas              = 5
  service_port              = 80
  target_tags               = ["${var.network_name}"]
  project		    = "${var.project}"
  network                   = "${google_compute_subnetwork.default.name}"
  subnetwork                = "${google_compute_subnetwork.default.name}"
  instance_labels           = "${var.labels}"
  update_strategy           = "NONE"
}

// null resource used to create dependency with the instance group data source to trigger a refresh.
resource "null_resource" "template" {
  triggers {
    instance_template = "${element(module.managed-webserver-group.instance_template, 0)}"
  }
}

data "google_compute_region_instance_group" "managed-webserver-group" {
  self_link  = "${module.managed-webserver-group.region_instance_group}"
  depends_on = ["null_resource.template"]
}


