output "kinesis_stream_arn" {
  value = aws_kinesis_stream.telemetry_stream.arn
}

output "raw_bucket" {
  value = aws_s3_bucket.raw_events.bucket
}
