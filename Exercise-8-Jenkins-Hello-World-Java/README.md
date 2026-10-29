# Exercise 8: Creating "Hello World" Jenkins Job

## Objective
Configure and run your first automated build job in Jenkins using a GitHub repository source and bash automation scripts.

## Workflow Overview
1. **Script Creation**: Author a clean executable script `hello-world.sh`.
2. **Version Control Integration**: Track the script in Git and link to GitHub.
3. **Jenkins Freestyle Project**:
   - Create a new item named `HelloWorld`.
   - Set project type to **Freestyle Project**.
   - Configure Git SCM repository URL.
   - Add build step: **Execute Shell** (`sh hello-world.sh`).
4. **Build Execution & Log Verification**: Trigger **Build Now** and inspect the console logs to confirm `Finished: SUCCESS`.

## Files in this Exercise
- `hello-world.sh`: Target shell script to be executed by Jenkins.
- `HelloWorld.java`: Java implementation of Hello World.
- `deploy.ps1`: Automated PowerShell execution test script.
- `deploy.sh`: Automated Bash execution script.
- `output.txt`: Captured console log output from Jenkins build run.

## Step-by-Step Instructions

### 1. Author the Script
Create `hello-world.sh`:
```bash
#!/bin/bash
echo "Hello, Jenkins!"
```
Make executable:
```bash
chmod +x hello-world.sh
```

### 2. Configure the Jenkins Job
1. Open Jenkins Web Interface (`http://localhost:8080`).
2. Click **New Item** -> Name: `HelloWorld` -> Select **Freestyle project** -> Click **OK**.
3. Under **Source Code Management**, select **Git** and enter your repository URL.
4. Under **Build Steps**, select **Add build step** -> **Execute shell**.
5. Input the command:
   ```bash
   sh hello-world.sh
   ```
6. Click **Save**.

### 3. Trigger and Verify Build
1. Click **Build Now** on the project page.
2. Under **Build History**, select build `#1` -> **Console Output**.
3. Confirm output:
   ```text
   Started by user Admin
   Building in workspace /var/jenkins_home/workspace/HelloWorld
   [HelloWorld] $ /bin/sh -xe /tmp/jenkins1281930102.sh
   + echo 'Hello, Jenkins!'
   Hello, Jenkins!
   Finished: SUCCESS
   ```

## Execution Proof & Screenshots

### 1. Script Creation, Execution Test & Git Tracking
![Script Creation and Git Tracking](screenshots/01_create_script_and_git_push.png)

### 2. Jenkins Freestyle Job Console Output & Build Success
![Jenkins Console Output](screenshots/02_jenkins_job_console_output.png)
