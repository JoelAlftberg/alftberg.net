resource "local_file" "ansible-inventory" {

    content = templatefile(
        "templates/template-inventory.yml", 
        {
            hostname = var.domain-name,
            ansible_host = var.linode_instance.instance.ip_address,
            ansible_user = "root"
        }
    )   

    filename = "inventory.yml"

}