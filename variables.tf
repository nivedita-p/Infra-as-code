
variable "project" {
  default = "npaul-203410"
}

variable "labels" {
  type    = "map"
  default = {}
}

variable "service_port" {
 default = 80
}

variable "service_port_name" {
 default = "lb-http"
}
 variable "http_health_check" {
  default = true
}

variable "region" {
  default = "europe-west2"
}

provider "google" {
  region = "${var.region}"
}

variable "network_name" {
  default = "network2"
}

