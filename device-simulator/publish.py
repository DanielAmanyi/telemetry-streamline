import boto3
import json
import time
import uuid
from random import randint, uniform

STREAM_NAME = "telemetry-streamline-stream"  # update if needed

kinesis = boto3.client("kinesis")


def generate_payload(device_id: str):
    """Simulates a real device telemetry payload."""

    return {
        "event_id": str(uuid.uuid4()),
        "device_id": device_id,
        "timestamp": int(time.time()),
        "metrics": {
            "temperature": uniform(20, 100),   # value between 20–100
            "cpu": uniform(1, 90),             # 1% to 90%
            "battery": uniform(5, 100)         # 5% to 100%
        }
    }


def main():
    print("Starting device simulator...")
    device_ids = ["device-001", "device-002", "device-003"]

    while True:
        for dev in device_ids:
            payload = generate_payload(dev)
            kinesis.put_record(
                StreamName=STREAM_NAME,
                Data=json.dumps(payload),
                PartitionKey=dev
            )

            print(f"Sent telemetry: {payload}")

        time.sleep(2)  # send every 2 seconds


if __name__ == "__main__":
    main()
