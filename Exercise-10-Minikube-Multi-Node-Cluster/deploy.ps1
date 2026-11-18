# PowerShell deployment script for Exercise 10: Multi-Node Multi-App Minikube Deployment
Write-Host "=== Exercise 10: Multi-Node Kubernetes Deployment with Pod Anti-Affinity ===" -ForegroundColor Cyan

# 1. Build images
Write-Host "`n[Step 1] Building Docker images..." -ForegroundColor Yellow
docker build -t product-catalog:latest -f Dockerfile.product .
docker build -t shopping-cart:latest -f Dockerfile.shopping .

# 2. Apply Kubernetes Manifests
Write-Host "`n[Step 2] Applying Kubernetes Deployments..." -ForegroundColor Yellow
kubectl apply -f product_catalog_deployment.yaml
kubectl apply -f shopping_cart_deployment.yaml

Write-Host "`n[Step 3] Applying Kubernetes Services..." -ForegroundColor Yellow
kubectl apply -f product_catalog_service.yaml
kubectl apply -f shopping_cart_service.yaml

# 3. Check Pod distribution
Write-Host "`n[Step 4] Verifying Pod Distribution across cluster nodes..." -ForegroundColor Yellow
kubectl get pods -o wide

Write-Host "`n=== Services ===" -ForegroundColor Green
kubectl get services -o wide

Write-Host "`n=== Exercise 10 Completed Successfully ===" -ForegroundColor Cyan
