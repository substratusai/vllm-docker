#!/usr/bin/env bash

set -x

export NUM_GPU=$(gpu-count.py)
export SERVED_MODEL_NAME=${SERVED_MODEL_NAME:-"${MODEL}"}

if [[ -z "${MODEL}" ]]; then
    echo "Missing required environment variable MODEL"
    exit 1
fi

if ${QUANTIZATION}; then
    if [[ -z "${DTYPE}" ]]; then
        echo "Missing required environment variable DTYPE"
        exit 1
    else
        python3 -m vllm.entrypoints.openai.api_server \
            --tensor-parallel-size ${NUM_GPU} \
            --worker-use-ray \
            --host 0.0.0.0 \
            --port "${PORT}" \
            --model "${MODEL}" \
            --gpu-memory-utilization "${GPU_MEMORY_UTILIZATION}" \
            --served-model-name "${SERVED_MODEL_NAME}" \
            --quantization "${QUANTIZATION}" \
            --dtype "${DTYPE}"
    fi
fi

python3 -m vllm.entrypoints.openai.api_server \
    --tensor-parallel-size ${NUM_GPU} \
    --worker-use-ray \
    --host 0.0.0.0 \
    --port "${PORT}" \
    --model "${MODEL}" \
    --gpu-memory-utilization "${GPU_MEMORY_UTILIZATION}" \
    --served-model-name "${SERVED_MODEL_NAME}"
