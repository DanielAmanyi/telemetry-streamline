import json
import boto3

dynamodb = boto3.resource('dynamodb')
ddb_table = dynamodb.Table("telemetry-streamline-device-state")

es = boto3.client('opensearchserverless')
s3 = boto3.client('s3')

RAW_BUCKET = "telemetry-streamline-raw-events"

def lambda_handler(event, context):
    """
    Routes telemetry to DynamoDB, OpenSearch, and S3.
    """
    for record in event.get("Records", []):
        payload = json.loads(record["kinesis"]["data"])

        # DynamoDB latest state
        ddb_table.put_item(Item=payload)

        # OpenSearch indexing (pseudo-call; actual client config needed)
        # es.index(...)

        # S3 raw lake
        s3.put_object(
            Bucket=RAW_BUCKET,
            Key=f"{payload['device_id']}/{payload['timestamp']}.json",
            Body=json.dumps(payload)
        )

    return {"status": "ok"}
