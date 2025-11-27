import json

def lambda_handler(event, context):
    """
    Processes failed events from DLQ for logging, cleanup, or replay.
    """
    failed = []

    for record in event.get("Records", []):
        body = json.loads(record["body"])
        failed.append(body)

        # Here: log, store, or requeue
        print("DLQ Event:", body)

    return {
        "status": "processed",
        "failed_count": len(failed)
    }
