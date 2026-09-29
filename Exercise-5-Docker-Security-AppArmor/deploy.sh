#!/usr/bin/env bash
set -e

echo "=== Exercise 5: Docker Security with AppArmor and Python ==="

# 1. Install AppArmor parser & load profile if running as root on Linux
if command -v apparmor_parser &> /dev/null; then
    echo -e "\n[Step 0] Loading AppArmor profile into Linux kernel..."
    sudo cp my-apparmor-profile /etc/apparmor.d/my-apparmor-profile || true
    sudo apparmor_parser -r /etc/apparmor.d/my-apparmor-profile || true
fi

# 2. Build Docker image
echo -e "\n[Step 1] Building Flask AppArmor Docker image..."
docker build -t flask-apparmor .

# 3. Apply profile via Python SDK
echo -e "\n[Step 2] Applying AppArmor profile using Python Docker SDK..."
python3 apply_apparmor.py

# 4. Test restricted actions
echo -e "\n[Step 3] Testing restricted actions..."
python3 test_restricted_actions.py

echo -e "\n=== Exercise 5 Completed Successfully ==="
