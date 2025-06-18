variable "environments" {
  type    = set(string)
  default = ["development", "staging", "production"]
}

variable "mongo_url" {
  type    = string
  default = "mongodb://mongo:27017/comments"
}
