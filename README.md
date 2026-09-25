# TR-1909 Deployment POC

This POC improves the Kubernetes deployment stage by automatically checking
deployment health after Helm deployment and providing clear failure information.

## Pipeline Status

| Branch | Status |
|---|---|
| main | ![main](https://github.com/arjit547/tr1909-deployment-poc/actions/workflows/test-runner.yml/badge.svg?branch=main) |
| master | ![master](https://github.com/arjit547/tr1909-deployment-poc/actions/workflows/test-runner.yml/badge.svg?branch=master) |
| develop | ![develop](https://github.com/arjit547/tr1909-deployment-poc/actions/workflows/test-runner.yml/badge.svg?branch=develop) |

## Deployment Health Check

After the Helm deployment, the pipeline checks:

- Kubernetes deployment rollout status
- Available replicas
- Unavailable replicas
- Pod status
- Deployment failures
- Kubernetes events

If a deployment fails, the GitHub Actions job fails and displays the Kubernetes failure reason.

## Grafana Dashboard

The POC also provides a Grafana dashboard showing:

- Deployment available replicas
- Deployment desired replicas
- Unavailable replicas
- Pod status
- Pod readiness
