# PowerShell deployment script for Exercise 5: Docker Security with AppArmor
Write-Host "=== Exercise 5: Docker Security with AppArmor and Python ===" -ForegroundColor Cyan

# 1. Build Docker Image
Write-Host "`n[Step 1] Building Flask AppArmor Docker image..." -ForegroundColor Yellow
docker build -t flask-apparmor .

# 2. Apply AppArmor Profile via Docker SDK
Write-Host "`n[Step 2] Applying AppArmor profile using Python Docker SDK..." -ForegroundColor Yellow
python apply_apparmor.py

# 3. Test Restricted Actions
Write-Host "`n[Step 3] Testing restricted actions (AppArmor confinement)..." -ForegroundColor Yellow
python test_restricted_actions.py

Write-Host "`n=== Exercise 5 Completed Successfully ===" -ForegroundColor Cyan
