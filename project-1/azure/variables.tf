variable "region_name" {
    default="eastus"
}
variable "resource_group_name" {
  default = "Static-website-hosting"
}
variable "project_name" {
  default = "Nextwork-project-terragorm-azure"
}
variable "storage_account_name" {
  default = "azurestaticwebsite"
}
variable "env_name" {
  default = "Dev"
}
variable "subscription_id" {
  type = string
  sensitive = true
}
variable "tenant_id" {
    type= string
  sensitive = true
}