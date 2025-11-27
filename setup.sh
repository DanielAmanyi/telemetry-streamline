#!/bin/bash

echo "Setting up Telemetry Streamline repository structure..."

# Create directories
mkdir -p infrastructure
mkdir -p functions/validator
mkdir -p functions/enrichment
mkdir -p functions/anomaly_detector
mkdir -p functions/router
mkdir -p functions/dlq_processor
mkdir -p device-simulator/payloads
mkdir -p analytics

# Create Terraform files
touch infrastructure/main.tf
touch infrastructure/providers.tf
touch infrastructure/variables.tf
touch infrastructure/outputs.tf
touch infrastructure/kinesis.tf
touch infrastructure/lambda.tf
touch infrastructure/dynamodb.tf
touch infrastructure/opensearch.tf
touch infrastructure/s3.tf
touch infrastructure/glue.tf
touch infrastructure/lineage.tf
touch infrastructure/schema_registry.tf
touch infrastructure/sns.tf
touch infrastructure/iam.tf
touch infrastructure/cloudwatch.tf
touch infrastructure/dlq.tf

# Create Lambda handlers and schema
touch functions/validator/handler.py
touch functions/validator/schema.json
touch functions/enrichment/handler.py
touch functions/anomaly_detector/handler.py
touch functions/router/handler.py
touch functions/dlq_processor/handler.py

# Create device simulator
touch device-simulator/publish.py
touch device-simulator/payloads/sample_device.json

# Create analytics files
touch analytics/athena_queries.sql
touch analytics/glue_schema.json

# Create README
touch README.md

echo "Repository structure created."

# Move whitepaper if exists
if [ -f "../Telemetry_Streamline_Whitepaper.pdf" ]; then
    cp ../Telemetry_Streamline_Whitepaper.pdf WHITEPAPER.pdf
    echo "Whitepaper moved into repo root."
else
    echo "Whitepaper not found in parent directory. Please copy it manually as WHITEPAPER.pdf."
fi

echo "Done."
