# Telemetry Streamline

Telemetry Streamline is a real-time, serverless data pipeline for ingesting, validating, enriching, routing, and analyzing high-volume telemetry from devices and applications. It is built entirely on AWS using Terraform and follows an event-driven, pay-per-use architecture optimized for scalability and operational efficiency.

---

## Features

- High-throughput ingestion with Amazon Kinesis  
- Schema validation using Lambda and DynamoDB  
- Metadata enrichment with lineage tracking  
- Intelligent routing to DynamoDB, S3, and OpenSearch  
- Fully serverless, auto-scaling design  
- Real-time anomaly detection and alerting via SNS  
- Automatic data cataloging with AWS Glue  
- End-to-end observability through CloudWatch Logs and OpenSearch  

---

## Architecture

![Telemetry Streamline Architecture](architecture.png)

Telemetry Streamline processes events through a staged workflow:

1. **Ingestion** – Events enter the system through a Kinesis Data Stream.  
2. **Validation** – The Validator Lambda checks schema integrity and rejects malformed input.  
3. **Enrichment** – The Enrichment Lambda adds metadata using lookup tables.  
4. **Routing** – The Router Lambda dispatches events to:  
   - DynamoDB for device state snapshots  
   - S3 for raw event storage  
   - OpenSearch for indexing and analytics  
5. **Anomaly Detection** – Outliers trigger the Anomaly Detector Lambda, which publishes alerts to SNS.  
6. **Cataloging** – AWS Glue crawls S3 to update the metadata catalog for analytics.  

---

## Repository Structure

infrastructure/ # Terraform IaC for all AWS resources
functions/ # Lambda function source code
device-simulator/ # Event generator for pipeline testing
analytics/ # Query templates and dashboards
setup.sh # Utility setup script
Telemetry_Streamline_Whitepaper.pdf
architecture.png

yaml
Copy code

---

## Deployment

### Build Lambda packages

./scripts/build.sh

shell
Copy code

### Initialize Terraform

cd infrastructure
terraform init

shell
Copy code

### Deploy infrastructure

terraform apply

yaml
Copy code

---

## Testing the Pipeline

Generate test events with the device simulator:

cd device-simulator
python3 publish.py

yaml
Copy code

Events are processed through validation, enrichment, routing, and anomaly detection.  
You can observe data in:

- DynamoDB device state table  
- S3 raw bucket  
- OpenSearch index  
- CloudWatch logs  
- SNS alert topic (if anomalies occur)

---

## Whitepaper

A detailed technical design document is included:

**[Telemetry Streamline Whitepaper](Telemetry_Streamline_Whitepaper.pdf)**

---

## Author

**Amanyi Daniel Sunday**  
Cloud Engineer • DevOps • Serverless  
GitHub: https://github.com/DanielAmanyi  
LinkedIn: https://www.linkedin.com/in/daniel-amanyi-87169472