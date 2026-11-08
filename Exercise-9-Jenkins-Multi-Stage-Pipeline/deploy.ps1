# PowerShell deployment script for Exercise 9: Jenkins Multi-Stage Pipeline
Write-Host "=== Exercise 9: Jenkins Multi-Stage Pipeline Execution ===" -ForegroundColor Cyan

# 1. Run Unit Tests locally
Write-Host "`n[Step 1] Running Unit Tests (Test Stage)..." -ForegroundColor Yellow
python -m unittest test_app.py

# 2. Simulate Local Mock Deployment
Write-Host "`n[Step 2] Mock Deployment (Deploy Stage)..." -ForegroundColor Yellow
$deployDir = ".\mock-deploy"
New-Item -ItemType Directory -Force -Path $deployDir | Out-Null
Copy-Item app.py -Destination $deployDir
Write-Host "Application successfully deployed to $deployDir" -ForegroundColor Green

# 3. Clean up mock deploy
Remove-Item -Recurse -Force $deployDir

Write-Host "`n=== Exercise 9 Completed Successfully ===" -ForegroundColor Cyan
