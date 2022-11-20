variable "env" {}
variable "namespace" {}
variable "aws_profile" {}
variable "aws_region" {}
variable "docker_registry" {
  default     = "docker.io"
}
variable "docker_image_tag" {
  default     = "latest"
}
