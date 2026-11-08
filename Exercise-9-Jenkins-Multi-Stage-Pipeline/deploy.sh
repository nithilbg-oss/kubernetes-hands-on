#!/usr/bin/env bash
set -e

echo "=== Exercise 9: Jenkins Multi-Stage Pipeline Execution ==="

# 1. Run Unit Tests
echo -e "\n[Step 1] Running Unit Tests (Test Stage)..."
python3 -m unittest test_app.py

# 2. Deploy Stage
echo -e "\n[Step 2] Mock Deployment (Deploy Stage)..."
mkdir -p ./mock-deploy
cp app.py ./mock-deploy/
echo "Application successfully copied to ./mock-deploy"

# 3. Clean up
rm -rf ./mock-deploy

echo -e "\n=== Exercise 9 Completed Successfully ==="
