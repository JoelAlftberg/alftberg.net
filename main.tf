terraform {
    required_providers {
        linode = {
            source = "linode/linode"
        }
    }
}

provider "linode" {
    # Specify your Linode API token
    token = var.linode-token
}

# Create a linode instance
resource "linode_instance" "instance" {
    label = var.instance-label
    image =  var.image
    region = var.region
    type = var.instance-type
    authorized_keys = var.ssh-key
    root_pass = var.root-pass
    tags = var.instance-tags
}

# Mount the persistent volume to our instance
resource "linode_volume" "persistent_volume" {
    label = var.persistent-volume-label
    region = var.region
    linode_id = linode_instance.instance.id
}

# Add your domain to Linode
# Note: make sure you have pointed your domain towards Linodes nameservers at your registrar
resource "linode_domain" "domain" {
    type = "master"
    domain = var.domain-name
    soa_email = var.linode-soa-email

}

# Add A records for you domains DNS zone
resource "linode_domain_record" "domain-record" {
    domain_id = linode_domain.domain.id
    record_type = "A"
    target = var.linode_instance.instance.ip_address
    name = var.domain-records
}

