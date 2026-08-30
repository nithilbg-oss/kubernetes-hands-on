# \# Exercise 2: Deploying a Flask Application on Kubernetes using Minikube

# 

# \## Overview

# This exercise demonstrates how to build a Docker image for a Python Flask application and deploy it on a local Kubernetes cluster using Minikube. The application is exposed through a Kubernetes Service and accessed using a web browser.

# 

# \## Objectives

# \- Create a Flask web application.

# \- Containerize the application using Docker.

# \- Load the Docker image into Minikube.

# \- Deploy the application using Kubernetes.

# \- Expose the application through a NodePort Service.

# \- Verify the application in a web browser.

# 

# \## Technologies Used

# \- Python

# \- Flask

# \- Docker

# \- Kubernetes

# \- Minikube

# \- kubectl

# \- Windows PowerShell

# 

# \## Project Structure

# 

# ```text

# Exercise-02-Minikube-Kubectl-Flask/

# ├── app.py

# ├── Dockerfile

# ├── flask-deployment.yaml

# ├── README.md

# └── screenshots/

# &#x20;   ├── kubernetes-status.png

# &#x20;   └── flask-browser.png

# ```

# 

# \## Application Details

# 

# The Flask application runs on port `15000` and displays:

# 

# `Hello from Flask on Kubernetes!`

# 

# \## Implementation Steps

# 

# \### 1. Build the Docker Image

# 

# ```powershell

# docker build -t flask-app:latest .

# ```

# 

# \### 2. Load the Image into Minikube

# 

# ```powershell

# minikube image load flask-app:latest

# ```

# 

# \### 3. Start Minikube

# 

# ```powershell

# minikube start

# ```

# 

# \### 4. Deploy the Application

# 

# ```powershell

# kubectl apply -f flask-deployment.yaml

# ```

# 

# \### 5. Verify Kubernetes Resources

# 

# ```powershell

# kubectl get pods

# kubectl get deployments

# kubectl get services

# ```

# 

# \### 6. Access the Application

# 

# ```powershell

# minikube service flask-app-service

# ```

# 

# The command opens the application through the Minikube Service tunnel.

# 

# \## Kubernetes Configuration

# 

# | Resource | Name |

# |---|---|

# | Deployment | `flask-app` |

# | Service | `flask-app-service` |

# | Container image | `flask-app:latest` |

# | Container port | `15000` |

# | Service type | `NodePort` |

# 

# \## Expected Output

# 

# The browser should display:

# 

# `Hello from Flask on Kubernetes!`

# 

# \## Screenshots

# 

# The `screenshots/` directory contains screenshots of the actual Kubernetes resource status and the Flask application running in a browser.

# 

# \## Conclusion

# 

# This exercise demonstrates how to containerize a Flask application, deploy it to Kubernetes using Minikube, expose it through a Service, and verify its output in a browser.



