variable "project_name" {
  type    = string
  default = "telemetry-streamline"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "kinesis_shard_count" {
  type    = number
  default = 1
}

# New variables required by the architecture
variable "raw_bucket_name" {
  type    = string
  default = "telemetry-streamline-raw-events"
}

variable "opensearch_domain_name" {
  type    = string
  default = "telemetry-streamline-search"
}

variable "ddb_table_name" {
  type    = string
  default = "telemetry-streamline-device-state"
}

