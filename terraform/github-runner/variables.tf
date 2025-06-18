# variables.tf
variable "github_token" {
  type        = string
  description = "GitHub token with repo permissions."
}

variable "github_owner" {
  type        = string
  description = "GitHub repository owner."
}

variable "github_repository" {
  type        = string
  description = "GitHub repository name."
}

variable "kubeconfig_path" {
  type        = string
  description = "Path to kubeconfig file."
  default     = "~/.kube/config"
}

variable "namespace" {
  type        = string
  default     = "action-runner-system"
  description = "Kubernetes namespace for the GitHub runner."
}

variable "runner_image" {
  type        = string
  default     = "summerwind/actions-runner:latest"
  description = "Docker image for the GitHub runner."
}

variable "runner_replicas" {
  type        = number
  default     = 1
  description = "Number of GitHub runner replicas."
}

variable "runner_labels" {
  type        = string
  default     = "minikube,kubernetes,helm,docker"
  description = "Labels for the GitHub runner."
}

variable "runner_resources_limits" {
  type        = map(string)
  default     = { cpu = "500m", memory = "512Mi" }
  description = "Resource limits for the GitHub runner container."
}

variable "runner_resources_requests" {
  type        = map(string)
  default     = { cpu = "250m", memory = "256Mi" }
  description = "Resource requests for the GitHub runner container."
}
