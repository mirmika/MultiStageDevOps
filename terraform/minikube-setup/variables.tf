variable "environments" {
  type    = set(string)
  default = ["development", "staging", "production"]
}
