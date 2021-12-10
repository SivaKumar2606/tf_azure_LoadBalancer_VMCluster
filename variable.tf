
variable access_key {}
variable secret_key {}
variable sub_id {}
variable tenant_id {}
variable rg_name {
    type = string
    default = "TEST-RG"
}
variable location {
    type = string
    default = "eastus"
}
variable machinecount {
    default = 2
}
variable env {
    type = string
    default = "TEST"
}
variable vnet_name {}
variable vnet_cidr {}
variable subnet_name {}
variable subnet_cidr {}