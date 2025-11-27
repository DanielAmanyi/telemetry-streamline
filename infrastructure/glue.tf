resource "aws_glue_crawler" "raw_crawler" {
  name          = "${var.project_name}-crawler"
  role          = aws_iam_role.lambda_exec.arn
  database_name = "${var.project_name}_db"

  s3_target {
    path = "s3://${aws_s3_bucket.raw_events.bucket}/"
  }
}
