##### variables Ec2

variable "create_instance" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = true
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  default     = ""
}

variable "name" {
  description = "Name to be used on EC2 instance created"
  type        = string
  default     = "ec2-by-terraform"
}

variable "image_name" {
  description = "Values datasource ami"
  type        = string
  default     = "ubuntu/*"
}

variable "owner" {
  description = "Owner ami"
  type        = any
  default     = "amazon"
}

variable "eip" {
  description = "Enabled eip"
  type        = bool
  default     = false
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with an instance in a VPC"
  type        = bool
  default     = false
}

variable "cpu_credits" {
  description = "The credit option for CPU usage (unlimited or standard)"
  type        = string
  default     = null
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  type        = bool
  default     = null
}

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  type        = list(map(string))
  default     = []
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = null
}

variable "ephemeral_block_device" {
  description = "Customize Ephemeral (also known as Instance Store) volumes on the instance"
  type        = list(map(string))
  default     = []
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
  default     = "key"
}

variable "launch_template" {
  description = "Specifies a Launch Template to configure the instance. Parameters configured on this resource will override the corresponding parameters in the Launch Template"
  type        = map(string)
  default     = null
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = false
}

variable "network_interface" {
  description = "Customize network interfaces to be attached at instance boot time"
  type        = list(map(string))
  default     = []
}

variable "private_ip" {
  description = "Private IP address to associate with the instance in a VPC"
  type        = string
  default     = null
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "user_data" {
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  type        = string
  default     = null
}

variable "user_data_base64" {
  description = "Can be used instead of user_data to pass base64-encoded binary data directly. Use this instead of user_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption."
  type        = string
  default     = null
}

variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  type        = map(string)
  default     = {}
}

variable "enable_volume_tags" {
  description = "Whether to enable volume tags (if enabled it conflicts with root_block_device tags)"
  type        = bool
  default     = false
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}

variable "timeouts" {
  description = "Define maximum timeout for creating, updating, and deleting EC2 instance resources"
  type        = map(string)
  default     = {}
}

variable "instance_count" {
  description = "Número de instâncias que serão provisionadas"
  type        = number
  default     = 1
}

variable "policy_additional" {
  description = "additional policy"
  type        = list(any)
  default     = []
}

variable "additional_policy" {
  description = "create policy"
  type        = bool
  default     = false
}

variable "azs" {
  description = "AZ to start the instance in"
  type        = string
  default     = null
}

variable "additional_rules_security_group" {
  description = "Rules security group"
  type        = any
  default     = {}
}

variable "use_data_ami" {
  type    = bool
  default = false
}

variable "ami" {
  type    = string
  default = ""
}