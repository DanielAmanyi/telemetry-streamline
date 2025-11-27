resource "aws_dynamodb_table" "device_state" {
  name         = "${var.project_name}-device-state"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "device_id"

  attribute {
    name = "device_id"
    type = "S"
  }
}

resource "aws_dynamodb_table" "schema_registry" {
  name         = "${var.project_name}-schema-registry"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "schema_id"

  attribute {
    name = "schema_id"
    type = "S"
  }
}

resource "aws_dynamodb_table" "lineage" {
  name         = "${var.project_name}-lineage"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "event_id"

  attribute {
    name = "event_id"
    type = "S"
  }
}
