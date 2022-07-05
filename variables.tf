variable "name" {
  type        = string
  description = "(Required) Name of the repository."
}

variable "immutable" {
  type        = bool
  description = "(Optional) You can configure a repository to be immutable to prevent image tags from being overwritten. Defaults to false"
  default     = true
}

variable "global_tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}

variable "scan_on_push" {
  type        = bool
  description = "(Optional) Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false). Defaults to true"
  default     = true
}

variable "encryption_type" {
  type        = string
  description = " The encryption type to use for the repository. Valid values are AES256 or KMS. Defaults to AES256"
  default     = "AES256"
}

variable "repository_policy_statements" {
  type        = any
  description = "(Optional) A list of repository policy statements."
  default     = []
}

variable "lifecycle_policy_rules" {
  type        = any
  description = "(Optional) List of lifecycle policy rules."
  default     = []
}

variable "pull_identities" {
  type        = list(string)
  description = "(Optional) List of AWS identity identifiers to grant cross account pull access to"
  default     = []
}

variable "push_identities" {
  type        = list(string)
  description = "(Optional) List of AWS identity identifiers to grant cross account pull and push access to"
  default     = []
}
