import json
import boto3
import time

dynamodb = boto3.resource('dynamodb')
lineage_table = dynamodb.Table("telemetry-streamline-lineage")

def lambda_handler(event, context):
    """
    Enriches telemetry with metadata and writes lineage entries.
    """
    enriched = []

    for record in event.get("Records", []):
        payload = json.loads(record["kinesis"]["data"])

        # Add metadata
        payload["processed_at"] = int(time.time())
        payload["source"] = "telemetry-streamline"

        # Lineage entry
        lineage_table.put_item(Item={
            "event_id": payload.get("event_id", str(time.time_ns())),
            "device_id": payload["device_id"],
            "timestamp": payload["timestamp"],
            "processed_at": payload["processed_at"]
        })

        enriched.append(payload)

    return {
        "status": "ok",
        "records_enriched": len(enriched)
    }
