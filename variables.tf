variable "linode-token" {
    type = string 
    description = "Your Linode API-token, generate this by signing in and go to https://cloud.linode.com/profile/tokens"
}

variable "instance-label" {
    type = string
    description = "Name that will be used to identify your Linode"
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
    description = "Linode Types, list them with $ curl https://api.linode.com/v4/types"
}

variable "ssh-pub-key" {
    type = string
    description = "Your SSH Public key"
}

variable "root-pass" {
    type = string
    description = "Set this to something secure and store it in a password manager, and configure SSHD to not accept root login remotely"
}

variable "instance-tags" {
    type = string
    description = "Tags for your instance, to easier filter/separate them in Linode"
}

variable "persistent-volume-label" {
    description = "Name that identifies your previously created persistent volume"
}

variable "domain-name" {
    type = string
    description = "A registered domain name"
}

variable "domain-record"  {
    type = list(string)
    description = "List of A records you want to add to the domain"
}