
variable "availability_zone_names" {
  type    = list(string)
  default = ["us-west-1a"]
}

output "zone_names" {
  value = "output1"
}
