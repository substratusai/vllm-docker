#!/usr/bin/env bash

set -x

export NUM_GPU=$(gpu-count.py)

if [[ -z "${MODEL}" ]]; then
    echo "Missing required environment variable MODEL"
    exit 1
fi

python3 -m vllm.entrypoints.openai.api_server \
    --tensor-parallel-size ${NUM_GPU} \
    --worker-use-ray \
    --host 0.0.0.0 \
    --port "${PORT}" \
    --model "${MODEL}" \
    --gpu-memory-utilization "${GPU_MEMORY_UTILIZATION}"
