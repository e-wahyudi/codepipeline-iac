variable "pipelinename" {
  default     = ""
  description = "Name of the Code Pipeline"
}

variable "role_arn" {
  default     = ""
  description = "Code Pipeline Service Role"
}

variable "artifact_store_location" {
  default     = ""
  description = "S3 bucket name to store artifact"
}

variable "repository_id" {
  default     = ""
  description = "Git repository format: organization/project_name"
}

variable "branch_name" {
  default     = ""
  description = "specify git branch name here"
}

variable "artifact" {
  default     = ""
  description = "this wil be used as the output artifact in Source stage and input artifact in the rest of the stages"
}

variable "stage1name" {
  default = ""
  description = "Stage 1 Name"
}

variable "stage1_action_name" {
  default = ""
  description = "Action Name in Stage 1"
}

variable "stage1category" {
  default = ""
  description = "Possible values are Approval, Build, Deploy, Invoke, Source and Test."
}

variable "project1" {
  default     = ""
  description = "project name in Stage 1"
}

variable "stage2name" {
  default = ""
  description = "Stage 2 Name"
}

variable "stage2_action_name" {
  default = ""
  description = "Action Name in Stage 2"
}

variable "stage2category" {
  default = ""
  description = "Possible values are Approval, Build, Deploy, Invoke, Source and Test."
}

variable "project2" {
  default     = ""
  description = "project in Stage2"
}