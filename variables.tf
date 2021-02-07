variable "image_id" {
  default     = "ami-0870650fde0fef2d4"
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "servers" {
  type        = number
  default     = 1
  description = " quantidade de instancias"
}

variable "environment" {
  type        = string
  default     = "staging"
  description = "The environment of instance"
}

variable "plus" {
  type        = number
  default     = 1
  description = " acresenta numero de instancia"
}

variable "production" {
  default = true
}

variable instance_type {
  type =  list(string)
  default = ["t2.micro", "t2.nano"]
  description = "Lista de tipos de instacia"
}
variable "blocks" {
  type = list(object({
    device_name = string
    volume_size = string
    volume_type = string
  }))
  description = "lista de volumes ebs"
}
