
output "instance_self_link_1" {
  value = "${lookup(data.google_compute_region_instance_group.managed-webserver-group.instances[0], "instance")}"
}

output "instance_status_1" {
  value = "${lookup(data.google_compute_region_instance_group.managed-webserver-group.instances[0], "status")}"
}

output "instance_self_link_2" {
  value = "${lookup(data.google_compute_region_instance_group.managed-webserver-group.instances[1], "instance")}"
}

output "instance_status_2" {
  value = "${lookup(data.google_compute_region_instance_group.managed-webserver-group.instances[1], "status")}"
}

output "instance_self_link_3" {
  value = "${lookup(data.google_compute_region_instance_group.managed-webserver-group.instances[2], "instance")}"
}

output "instance_status_3" {
  value = "${lookup(data.google_compute_region_instance_group.managed-webserver-group.instances[2], "status")}"
}

#output "health_check" {
#  description = "The healthcheck for the managed instance group"
#  value       = "${element(concat(data.google_compute_health_check.managed-webserver-group-health-check.*.self_link, list("")), 0)}"
#}
#

