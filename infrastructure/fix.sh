#!/bin/bash

echo "=== Fixing Telemetry Streamline Terraform Structure ==="

# 1. Fix main.tf
echo "[1/4] Replacing main.tf with clean version..."
cat > main.tf <<'EOF'
# main.tf
# Terraform automatically loads all .tf files in this directory.
# Keep this file minimal.
EOF

# 2. Backup and remove duplicate DynamoDB files
echo "[2/4] Backing up and removing duplicate DynamoDB table files..."

for f in lineage.tf schema_registry.tf; do
  if [ -f "$f" ]; then
    mv "$f" "${f}.bak"
    echo "  - Backed up $f to $f.bak"
    rm -f "$f"
    echo "  - Removed $f"
  else
    echo "  - $f not found (already cleaned)"
  fi
done

# 3. Replace dynamodb.tf with consolidated version
echo "[3/4] Rewriting dynamodb.tf to include all DynamoDB tables..."

cat > dynamodb.tf <<'EOF'
resource "aws_dynamodb_table" "device_state" {
  name         = "${var.project_name}-device-state"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "device_id"

  attribute {
    name = "device_id"
    type = "S"
  }
}

resource "aws_dynamodb_table" "schema_registry" {
  name         = "${var.project_name}-schema-registry"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "schema_id"

  attribute {
    name = "schema_id"
    type = "S"
  }
}

resource "aws_dynamodb_table" "lineage" {
  name         = "${var.project_name}-lineage"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "event_id"

  attribute {
    name = "event_id"
    type = "S"
  }
}
EOF

echo "[4/4] Cleaning complete. Running sanity check..."

grep -n "resource \"aws_dynamodb_table\"" *.tf || true

echo "=== DONE ==="
echo "Next: run 'terraform init' again."
