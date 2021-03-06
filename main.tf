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
    region = var.region
    type = var.instance-type
    tags = var.instance-tags

    # Boot volume
    disk {
        label = "boot"
        size = var.root-disk-size
        image =  var.image
        authorized_keys = var.ssh-pub-keys
        root_pass = var.root-password
    }

    # Attach the persistent volume
    config {
        label = "attach-persistent-volume"

        devices {
            sda {
                disk_label = "boot"
            }
            sdb {
                volume_id  = var.persistent-volume-id
            }
        }

        root_device = "/dev/sda"
    }

    connection {
        type = "ssh"
        user = "root"
        password = var.root-password
        host = linode_instance.instance.ip_address
    }

    provisioner "remote-exec" {
        inline = ["sudo apt update", "sudo apt upgrade -y", "sudo apt install python3 -y", echo Done!"]
    }

} # End of instance

# Add your domain to Linode
# Note: make sure you have pointed your domain towards Linodes nameservers at your registrar
resource "linode_domain" "domain" {
    type = "master"
    domain = var.domain-name
    soa_email = var.domain-soa-email
}

# Add A records for you domains DNS zone
resource "linode_domain_record" "domain-record" {
    # Iterate through the list of records
    for_each = var.domain-records

    domain_id = linode_domain.domain.id
    record_type = "A"
    target = linode_instance.instance.ip_address
    ttl_sec = var.domain-records-ttl

    name = each.value
}

# Run Ansible playbook which includes all roles
resource "null_resource" "ansible-play" {

    triggers = {
        always_run = timestamp()

    }
    provisioner "local-exec" {
        command = "ansible-playbook -i ${local_file.ansible-inventory.filename} ${var.ansible-playbook} --private-key=${var.ssh-private}"
    }

}

