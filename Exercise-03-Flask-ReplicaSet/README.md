# Exercise 3: Scaling a Flask App on a Single Node Using ReplicaSets

## Objective
- Understand Kubernetes ReplicaSets and Pods.
- Deploy a Flask flash-sale application.
- Scale the application from 3 to 5 replicas.
- Verify that Kubernetes replaces a deleted Pod.
- Access the application through a Kubernetes Service.

## Use case
During an e-commerce flash sale, request traffic can increase suddenly. A ReplicaSet maintains the requested number of identical application Pods. This exercise starts with 3 replicas, scales to 5, and tests self-healing by deleting one Pod.

## Files
- `app.py` — Flask endpoints `/`, `/buy`, and `/health`.
- `Dockerfile` — builds the Flask application image.
- `flashsale-replicaset.yaml` — ReplicaSet and NodePort Service.
- `screenshots/` — save your own screenshots of the commands and results.

## Requirements
Docker Desktop, Minikube, kubectl, and PowerShell on Windows.

> Do not delete your existing Minikube cluster. The steps below use the current `minikube` profile.

## 1. Build the image
Run these commands from this folder:

```powershell
docker build -t flashsale:1.0 .
minikube image load flashsale:1.0
minikube start
```

## 2. Deploy the ReplicaSet and Service

```powershell
kubectl apply -f flashsale-replicaset.yaml
```

## 3. Verify the initial 3 replicas

```powershell
kubectl get rs
kubectl get pods -l app=flashsale
```

Wait until all three Pods show `1/1` READY and `Running`.

## 4. Scale from 3 to 5 replicas

```powershell
kubectl scale rs flashsale-rs --replicas=5
kubectl get rs
kubectl get pods -l app=flashsale -o wide
```

Confirm that five Pods are ready.

## 5. Test self-healing

Get the Pod names:

```powershell
kubectl get pods -l app=flashsale
```

Delete one Pod using its actual name:

```powershell
kubectl delete pod <replace-with-an-actual-pod-name>
```

Then verify Kubernetes creates a replacement:

```powershell
kubectl get pods -l app=flashsale
```

Do not type the angle-bracket placeholder literally; replace it with a real Pod name from your output.

## 6. Access the application

```powershell
minikube service flashsale-svc --url
```

Keep that terminal open if it says a tunnel is running. Copy the URL it prints and open it in a browser. Add `/buy` or `/health` to the URL to test those endpoints.

Example paths:
- `/` — welcome message and Pod name.
- `/buy?user=123` — simulated purchase response and serving Pod.
- `/health` — health status.

## Screenshots
Save your own screenshots in `screenshots/`, including:
1. Image build and successful manifest apply.
2. Initial 3 ready replicas.
3. 5 ready replicas after scaling.
4. Pod replacement after deletion.
5. Browser or terminal responses from the service.

## Key observations
- A ReplicaSet maintains the desired number of Pods.
- Scaling from 3 to 5 creates two additional Pods.
- Deleting a managed Pod causes the ReplicaSet to create a replacement.
- `kubectl get pods -o wide` shows the node hosting each Pod. With a single-node cluster, all Pods should be on that node.

## Conclusion
This exercise demonstrates ReplicaSet scaling, Pod management, service access, and Kubernetes self-healing on a local Minikube cluster.
