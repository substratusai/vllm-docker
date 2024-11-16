#!/usr/bin/env bash

set -xe

IMAGE_TAG="${IMAGE_TAG:-vllm/vllm-openai:latest}"
MODEL_NAME="${MODEL_NAME:-facebook/opt-125m}"

docker run --rm -d --name vllm -p 8000:8000 ${IMAGE_TAG} \
  --model ${MODEL_NAME} ${ARGS}

# Wait for up to 120 seconds for the Docker container to be ready
echo "Waiting for the container to be ready..."
timeout=120
while ! curl -sf http://localhost:8000/v1/models; do
  sleep 5
  timeout=$((timeout-5))
  if [ "$timeout" -le 0 ]; then
    echo "Timed out waiting for container to respond."
    docker logs vllm
    exit 1
  fi
done
echo "Container is ready."

curl -v http://localhost:8000/v1/completions \
  -H "Content-Type: application/json" \
  -d '{
  "model": "facebook/opt-125m",
  "prompt": "San Francisco is a",
  "max_tokens": 7,
  "temperature": 0
}'
CURL_EXIT_CODE=$?
if [ $CURL_EXIT_CODE -ne 0 ]; then
  echo "Curl command failed with exit code $CURL_EXIT_CODE"
  echo "Outputting Docker logs:"
  docker logs vllm
fi
exit $CURL_EXIT_CODE