resource "aws_kinesis_stream" "telemetry_stream" {
  name             = "${var.project_name}-stream"
  shard_count      = var.kinesis_shard_count
  retention_period = 24
}
