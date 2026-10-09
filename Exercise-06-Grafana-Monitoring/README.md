# Exercise 6: Real-Time Operations Monitoring and Alerting

## Overview

This project demonstrates a monitoring setup for a simulated quick-commerce delivery service. A Python application publishes delivery metrics, Prometheus collects and evaluates those metrics, and Grafana visualizes operational trends. Alert rules identify high pending-delivery counts and high average delivery times.

## Objectives

- Create a Python metrics publisher using `prometheus_client`.
- Expose delivery metrics over HTTP on port `8000`.
- Configure Prometheus to scrape the metrics endpoint.
- Define alert rules for delivery operations.
- Use Grafana to build a dashboard from Prometheus data.
- Include a Jenkins pipeline for container build and deployment automation, if required by the assignment.

## Project Structure

```text
Exercise-06-Grafana-Monitoring/
├── delivery_metrics.py
├── Dockerfile
├── prometheus.yml
├── alert_rules.yml
├── Jenkinsfile
├── README.md
├── 6-Grafana-Realtime-Monitoring-of-Quick-Commerce-App.md
└── screenshots/
```

## Components

### 1. Delivery metrics application

`delivery_metrics.py` simulates delivery activity and publishes these metrics:

- `total_deliveries` — current simulated total.
- `pending_deliveries` — deliveries waiting to be dispatched.
- `on_the_way_deliveries` — deliveries currently in transit.
- `average_delivery_time` — observations of simulated delivery duration.

The metrics HTTP server listens on port `8000`. The Prometheus client exposes the metrics at `/metrics`.

### 2. Docker image

The `Dockerfile` packages the Python application and installs `prometheus-client`. The image exposes port `8000`.

Build the image from this directory:

```powershell
docker build -t delivery-metrics .
```

Run the application container:

```powershell
docker run -d --name delivery_metrics -p 8000:8000 delivery-metrics
```

If a container named `delivery_metrics` already exists, inspect it before deciding whether to stop or remove it. Do not remove unrelated containers.

### 3. Prometheus

`prometheus.yml` configures Prometheus to scrape itself and the delivery metrics endpoint every five seconds. The supplied delivery target is `host.docker.internal:8000`, which is appropriate when the metrics application is reachable from the Docker host. Confirm the target is reachable in your actual deployment.

Prometheus is normally exposed at:

```text
http://localhost:9090
```

Check the target status in **Status → Targets**. The delivery-service target should show as `UP` before you rely on its metrics.

### 4. Alert rules

`alert_rules.yml` defines these alerts:

- **HighPendingDeliveries** — pending deliveries remain above `10` for `15s`.
- **HighAverageDeliveryTime** — the calculated average delivery time exceeds `30` seconds.

After Prometheus loads the rule file, review **Alerts** in the Prometheus UI and confirm the rules are loaded. Alert states depend on the actual metric values.

### 5. Grafana

Grafana is exposed at:

```text
http://localhost:3000
```

Add Prometheus as a data source. If Grafana and Prometheus run as separate Docker containers, use an address reachable from the Grafana container; `localhost:9090` inside the Grafana container refers to Grafana itself, not the Prometheus container.

Create dashboard panels using queries such as:

```promql
total_deliveries
pending_deliveries
on_the_way_deliveries
average_delivery_time_sum / average_delivery_time_count
```

The average-time query is meaningful after observations have been recorded and the count is greater than zero.

## Setup and Verification

### Prerequisites

- Docker Desktop running on Windows.
- Python 3.10 or later if running the metrics application directly on Windows.
- The project files listed above.
- Jenkins only if pipeline automation is required.

### Verify the metrics endpoint

After starting the metrics application, open:

```text
http://localhost:8000/metrics
```

Or use PowerShell:

```powershell
curl.exe http://localhost:8000/metrics
```

Look for `total_deliveries`, `pending_deliveries`, and `on_the_way_deliveries`.

### Verify Docker containers

```powershell
docker ps
```

Check that the relevant application and monitoring containers are running and their ports are published as expected.

### Verify Prometheus

Open `http://localhost:9090`, select **Status → Targets**, and check that the delivery-service target is `UP`. Then query `pending_deliveries` in the expression browser.

### Verify Grafana

Open `http://localhost:3000`, configure the Prometheus data source, and use **Save & test**. Create a dashboard with the delivery metrics listed above.

### Verify alerts

Open the Prometheus **Alerts** page. Confirm that `HighPendingDeliveries` and `HighAverageDeliveryTime` are loaded. Record the actual state shown by your environment; alert states depend on live metric values.

## Jenkins Pipeline

The included `Jenkinsfile` is a reference pipeline for building the application image and starting the monitoring containers. Review it before running: it uses Unix-style shell steps (`sh`) and assumes the Jenkins agent has Docker access. Those assumptions must be satisfied by the Jenkins environment. Do not run the pipeline unchanged if its commands or container names conflict with your setup.

## Screenshots

Save your own screenshots in the `screenshots/` directory. Suggested evidence:

1. `01-run-metrics-app.png` — Python application logs or running container.
2. `02-curl-metrics-endpoint.png` — metrics returned from `/metrics`.
3. `03-prometheus-config-and-launch.png` — relevant containers and configuration.
4. `04-prometheus-query-ui.png` — a successful Prometheus metric query.
5. `05-prometheus-alerts-firing.png` — actual alert status in Prometheus.
6. `06-grafana-dashboard.png` — your Grafana dashboard.
7. `07-jenkinsfile-pipeline.png` — Jenkins pipeline or Jenkinsfile, if Jenkins is required.

Only include screenshots you actually captured. Do not present sample outputs or another person's screenshots as your own results.

## Troubleshooting

- **Metrics endpoint unavailable:** Check the application/container logs and confirm port `8000` is listening and published.
- **Prometheus target is DOWN:** Verify that the target address is reachable from the Prometheus container and that the application is running.
- **Grafana cannot connect to Prometheus:** Use a container-reachable Prometheus address rather than assuming `localhost` refers to another container.
- **Port already allocated:** Identify which process or container is using the port before changing or stopping anything.
- **Jenkins pipeline fails:** Confirm the agent OS, Docker CLI availability, Docker daemon access, and shell assumptions.

## Completion Checklist

- [ ] Delivery metrics are visible at `/metrics`.
- [ ] Prometheus delivery-service target is `UP`.
- [ ] Prometheus queries return delivery metrics.
- [ ] Alert rules are loaded and their observed states are recorded.
- [ ] Grafana data source connects successfully.
- [ ] Dashboard panels display the metrics.
- [ ] Jenkins pipeline is tested if required.
- [ ] Your own screenshots are saved in `screenshots/`.

## Summary

This exercise combines application instrumentation, metrics collection, alerting, visualization, containers, and optional CI/CD automation. Mark each checklist item complete only after verifying it in your own environment.
