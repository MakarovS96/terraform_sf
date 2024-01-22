variable "instance_family_image" {
  description = "instance family name"
  type = string
  default = "lamp"
}

variable "vpc_subnet_id" {
  description = "id of subnet"
  type = string
}

variable "zone" {
  description = "Zone of availability"
  type = string
}