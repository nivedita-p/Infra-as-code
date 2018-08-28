# Specify name of the project here
variable "project" {
  default = "vagarwal-203410"
}

variable "labels" {
  type    = "map"
  default = {}
}

# Specify the port on which to listen for the service here
variable "service_port" {
 default = 80
}

variable "name" {
 default = "nivi-mig"
}

# Specify the port name here, will be used for healthcheck
variable "service_port_name" {
 default = "lb-http"
}

# Specify whether to enable or disable health-checks here, must be true to use backend-service
 variable "http_health_check" {
  default = true
}

variable "region" {
  default = "europe-west2"
}

provider "google" {
  region = "${var.region}"
}

variable "network" {
  default = "network2"
}

variable "subnetwork" {
  default = "network2"
}


# Change this to scale out or in
variable "no_of_vms" {
  default = 3
}
