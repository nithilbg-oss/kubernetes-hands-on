#!/usr/bin/env bash
set -e

echo "=== Exercise 10: Multi-Node Kubernetes Deployment with Pod Anti-Affinity ==="

# 1. Build images
echo -e "\n[Step 1] Building Docker images..."
docker build -t product-catalog:latest -f Dockerfile.product .
docker build -t shopping-cart:latest -f Dockerfile.shopping .

# 2. Apply Kubernetes Manifests
echo -e "\n[Step 2] Applying Kubernetes Deployments..."
kubectl apply -f product_catalog_deployment.yaml
kubectl apply -f shopping_cart_deployment.yaml

echo -e "\n[Step 3] Applying Kubernetes Services..."
kubectl apply -f product_catalog_service.yaml
kubectl apply -f shopping_cart_service.yaml

# 3. Check Pod distribution
echo -e "\n[Step 4] Verifying Pod Distribution across cluster nodes..."
kubectl get pods -o wide

echo -e "\n=== Services ==="
kubectl get services -o wide

echo -e "\n=== Exercise 10 Completed Successfully ==="
