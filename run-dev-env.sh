#!/bin/bash
set -euo pipefail
trap cleanup EXIT

function cleanup() {
  docker stop remote-dev-test-svc &> /dev/null || true
}

cleanup

docker build -f src/main/docker/Dockerfile.fast-jar -t remote-dev-test-builder .

docker run -d --rm \
  --name remote-dev-test-svc \
  -p 8080:8080 \
  -e QUARKUS_LAUNCH_DEVMODE=true \
  remote-dev-test-builder -Dquarkus.live-reload.password=123

# wait for app startup
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://localhost:8080/health)" != "200" ]]; do
  echo "not ready yet"
  sleep 2;
done

echo "ready!"

./mvnw compile quarkus:remote-dev -Dquarkus.live-reload.url=http://localhost:8080 -Dquarkus.live-reload.password=123