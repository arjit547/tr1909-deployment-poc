
#!/bin/bash

set -u

NAMESPACE="$1"

echo "======================================"
echo " TR-1909 Kubernetes Health Check"
echo " Namespace: $NAMESPACE"
echo "======================================"

echo ""
echo "=== DEPLOYMENTS ==="

kubectl get deployments \
  -n "$NAMESPACE" \
  -o wide

echo ""
echo "=== PODS ==="

kubectl get pods \
  -n "$NAMESPACE" \
  -o wide

FAILED=0

echo ""
echo "=== ROLLOUT CHECK ==="

for deployment in $(kubectl get deployments \
  -n "$NAMESPACE" \
  -o jsonpath='{.items[*].metadata.name}')
do

    echo ""
    echo "Checking: $deployment"

    if kubectl rollout status \
        deployment/"$deployment" \
        -n "$NAMESPACE" \
        --timeout=60s
    then

        echo "✅ $deployment is healthy"

    else

        echo "❌ $deployment FAILED"

        FAILED=1

        echo ""
        echo "=== DEPLOYMENT DETAILS ==="

        kubectl describe deployment \
          "$deployment" \
          -n "$NAMESPACE"

    fi

done

echo ""
echo "=== KUBERNETES EVENTS ==="

kubectl get events \
  -n "$NAMESPACE" \
  --sort-by=.lastTimestamp | tail -30

if [ "$FAILED" -eq 1 ]; then

    echo ""
    echo "❌ DEPLOYMENT HEALTH CHECK FAILED"

    exit 1

else

    echo ""
    echo "✅ ALL DEPLOYMENTS ARE HEALTHY"

fi
