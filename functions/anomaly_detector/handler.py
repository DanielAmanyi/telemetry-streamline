import json
import boto3

sns = boto3.client('sns')
SNS_TOPIC = "telemetry-streamline-alerts"

def lambda_handler(event, context):
    """
    Detects anomalies in device metrics (simple rule-based).
    """
    for record in event.get("Records", []):
        payload = json.loads(record["kinesis"]["data"])
        metrics = payload["metrics"]

        anomalies = []

        if metrics.get("temperature", 0) > 80:
            anomalies.append("High temperature")

        if metrics.get("battery", 100) < 15:
            anomalies.append("Low battery")

        if anomalies:
            message = {
                "device_id": payload["device_id"],
                "timestamp": payload["timestamp"],
                "anomalies": anomalies,
                "metrics": metrics
            }

            sns.publish(
                TopicArn=SNS_TOPIC,
                Message=json.dumps(message),
                Subject="TelemetryStreamline: Device Anomaly Detected"
            )

    return {"status": "ok"}
