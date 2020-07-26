#!/bin/bash
set -euo pipefail

trap cleanup EXIT

function cleanup() {
  docker stop remote-dev-test-svc &> /dev/null || true
}


cleanup

#make dev-start

# coffee-shop

docker build -f Dockerfile.dev -t remote-dev-test-builder .

# wait for db startup
sleep 5

docker run -d --rm \
  --name remote-dev-test-svc \
  -p 8080:8080 \
  -v ~/.m2/:/root/.m2/ \
  remote-dev-test-builder

# wait for app startup
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://localhost:8080/health)" != "200" ]]; do
  sleep 2;
done

./mvnw compile quarkus:remote-dev -Dquarkus.live-reload.url=http://localhost:8080/ -Dquarkus.live-reload.password=123