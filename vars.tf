variable "ports_to_open" {
    type = list
    default = [443,22,8834]
}

variable "approved_key_name" {
  type = string
}

variable "approved_ips" {
  type = string
  default = "0.0.0.0/0"
}