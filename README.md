# Highly Available Webservice

This modules creates a set HA webservers behind a loadbalancer on Google Cloud Platform using terraform. It makes use of Managed Instance Group to create specified number of webservers hosting the application, using https://github.com/GoogleCloudPlatform/terraform-google-managed-instance-group.git. It also creates a HTTP healthcheck to monitor the health of the service, by listening to port 80 of every webserver, if webserver doesn't reply within 30 seconds, traffic will not be routed to that instance. It also makes use of Google autoscaler, if CPU utilization is more than 80%, it will spin up another VM and add it to the loadbalancer automatically. If you want to scale up manually, change `no_of_vms` in variables.tf, it can scale out to max 5 instances, however, that can be changed to from main.tf. The instances are created in different zones within a region, using google external/http loadbalancer using google backend service.

# Setup
 - Install terraform
 - Create a service account with editor privileges and download the key
 - Create a bucket to store terraform state
 - Update the relevant variables in vars.tf
 - Set environment variable `GOOGLE_APPLICATION_CREDENTIALS=/path/to/service-account.json`

# Usage
 - `cd interview-tf-solution`
 - `terraform init`
 - `terraform plan`
 - `terraform apply`

