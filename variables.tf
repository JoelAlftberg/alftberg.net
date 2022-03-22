variable "linode-token" {
    type = string 
    description = "Your Linode API-token, generate this by signing in and go to https://cloud.linode.com/profile/tokens"
}

variable "instance-label" {
    type = string
    description = "Name that will be used to identify your Linode"
}

variable "root-disk-size" {
    type = number
    default = 30000
    description = "Size of the root volume"
}

variable "image" {
    type = string
    default = "linode/debian11"
    description = "Linode Images, list them with $ curl https://api.linode.com/v4/images"
}

variable "region" {
    type = string
    default = "eu-central"
    description = "Your nearest/favorite linode region" 
}

variable "instance-type" {
    type = string
    description = "Linode Types, list them with $ curl https://api.linode.com/v4/linode/types"
}

variable "ssh-pub-keys" {
    type = list(string)
    description = "Your SSH Public key"
}

variable "ssh-private-key" {
    type = string
    description = "SSH Private key to be used with ansible, should correspond with previously entered public key"
    default = "~/.ssh/id_rsa"
}

variable "root-password" {
    type = string
    description = "Set this to something secure and store it in a password manager, and configure SSHD to not accept root login remotely"
}

variable "instance-tags" {
    type = list(string)
    description = "Tags for your instance, to easier filter/separate them in Linode"
}

variable "persistent-volume-id" {
    type = number
    # TODO: Add script that gets volume-id via curl automatically depending on new variable persistent-volume-label
    description = "Number that identifies your previously created persistent volume, can be gotten via API $ curl -H 'Authorization: Bearer $TOKEN' https://api.linode.com/v4/volumes"
}

variable "domain-name" {
    type = string
    description = "A registered domain name"
}

variable "domain-soa-email" {
    type = string
    description = "SOA E-mail address for your domain"
}

variable "domain-records"  {
    type = map(string)
    description = "Map of A records you want to add to the domain, variable is defined like this for example ['www', '@']"
}

variable "domain-records-ttl" {
    type = number
    description = "Time To Live for the records created"
}
