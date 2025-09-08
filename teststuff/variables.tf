# Defining variables for use later

# The name of the static website bucket in AWS
variable "web-bucket" {
  type = string
  description = "The name of the website bucket"
}

# Some tags for the project - just best practice!
variable "challenge-tags" {
  description = "Tags that are used for the project"
}