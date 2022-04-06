resource "local_file" "ansible-inventory" {

    content = templatefile(
        "templates/inventory.tftpl", 
        {
            hostname = var.domain-name,
            ansible_host = linode_instance.instance.ip_address,
            ansible_user = "root"
        }
    )   

    filename = "inventory.yml"

}