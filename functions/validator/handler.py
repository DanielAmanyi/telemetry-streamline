import json
import boto3

def lambda_handler(event, context):
    """
    Validates incoming telemetry payloads against a schema.
    Sends invalid events to DLQ via Lambda's built-in DLQ config.
    """
    output_records = []

    for record in event.get("Records", []):
        payload = json.loads(record["kinesis"]["data"])

        # Example schema fields
        required_fields = ["device_id", "timestamp", "metrics"]

        if not all(field in payload for field in required_fields):
            # Fail fast – triggers DLQ routing
            raise ValueError(f"Schema validation failed: {payload}")

        output_records.append(payload)

    return {
        "status": "ok",
        "records_validated": len(output_records)
    }
