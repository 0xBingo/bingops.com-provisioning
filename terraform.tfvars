# `node.tf` values

node_name = "homelab"

nodes = {
  web = {
    host_ip         = "192.168.1.120/24"
    gw              = "192.168.1.1"
    vm_id           = 120
    cores           = 2
    memory          = 2048 # 2GB
    network_bridge  = "vmbr0"
    role            = "master"
  },
}

datastore = "local-lvm"
template_vm_id = "9999"
