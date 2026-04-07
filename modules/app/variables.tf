variable "ecr_repository_name" {
  type = string

}
variable "app_path" {
  type = string
}
variable "image_version" {
  type = string
}
variable "app_name" {
  type = string
}
variable "port" {
  type = number
}
variable "execution_role_arn" {
  type = string
}
variable "cluster_arn" {
  type = string
}
variable "is_public" {
  default = true
  type    = bool
}
variable "subnets" {
  type = list(string)
}
variable "app_security_group_id" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "path_pattern" {
  type = string
}
variable "alb_listener_arn" {
  type = string
}
variable "healthcheck_path" {
  type    = string
  default = "/*"
}