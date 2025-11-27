resource "aws_opensearch_domain" "telemetry" {
  domain_name = "${var.project_name}-search"

  engine_version = "OpenSearch_2.11"

  cluster_config {
    instance_type  = "t3.small.search"
    instance_count = 1
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }
}
