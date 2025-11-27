locals {
  lambda_paths = {
    validator        = "../functions/validator.zip"
    enrichment       = "../functions/enrichment.zip"
    anomaly_detector = "../functions/anomaly_detector.zip"
    router           = "../functions/router.zip"
    dlq_processor    = "../functions/dlq_processor.zip"
  }
}

resource "aws_lambda_function" "validator" {
  function_name = "${var.project_name}-validator"
  handler       = "handler.lambda_handler"
  runtime       = "python3.10"
  filename      = local.lambda_paths["validator"]
  role          = aws_iam_role.lambda_exec.arn

  environment {
    variables = {
      SCHEMA_TABLE = aws_dynamodb_table.schema_registry.name
    }
  }
}

resource "aws_lambda_function" "enrichment" {
  function_name = "${var.project_name}-enrichment"
  handler       = "handler.lambda_handler"
  runtime       = "python3.10"
  filename      = local.lambda_paths["enrichment"]
  role          = aws_iam_role.lambda_exec.arn

  environment {
    variables = {
      LINEAGE_TABLE = aws_dynamodb_table.lineage.name
    }
  }
}

resource "aws_lambda_function" "router" {
  function_name = "${var.project_name}-router"
  handler       = "handler.lambda_handler"
  runtime       = "python3.10"
  filename      = local.lambda_paths["router"]
  role          = aws_iam_role.lambda_exec.arn

  environment {
    variables = {
      DEVICE_STATE_TABLE = aws_dynamodb_table.device_state.name
      RAW_BUCKET         = aws_s3_bucket.raw_events.bucket
    }
  }
}

resource "aws_lambda_function" "anomaly_detector" {
  function_name = "${var.project_name}-anomaly-detector"
  handler       = "handler.lambda_handler"
  runtime       = "python3.10"
  filename      = local.lambda_paths["anomaly_detector"]
  role          = aws_iam_role.lambda_exec.arn

  environment {
    variables = {
      ALERT_TOPIC = aws_sns_topic.alerts.arn
    }
  }
}

resource "aws_lambda_function" "dlq_processor" {
  function_name = "${var.project_name}-dlq"
  handler       = "handler.lambda_handler"
  runtime       = "python3.10"
  filename      = local.lambda_paths["dlq_processor"]
  role          = aws_iam_role.lambda_exec.arn
}

# Event Source Mapping
resource "aws_lambda_event_source_mapping" "validator_source" {
  event_source_arn  = aws_kinesis_stream.telemetry_stream.arn
  function_name     = aws_lambda_function.validator.arn
  starting_position = "LATEST"
  batch_size        = 200
  enabled           = true
}
