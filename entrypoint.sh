#!/usr/bin/env bash

set -x

export NUM_GPU=$(gpu-count.py)
export SERVED_MODEL_NAME=${SERVED_MODEL_NAME:-"${MODEL}"}

if [[ -z "${MODEL}" ]]; then
    echo "Missing required environment variable MODEL"
    exit 1
fi

additional_args=${EXTRA_ARGS:-""}
if [[ ! -z "${QUANTIZATION}" ]]; then
    additional_args="${additional_args} -q ${QUANTIZATION}"
fi

python3 -m vllm.entrypoints.openai.api_server \
    --tensor-parallel-size ${NUM_GPU} \
    --worker-use-ray \
    --host 0.0.0.0 \
    --port "${PORT}" \
    --model "${MODEL}" \
    --gpu-memory-utilization "${GPU_MEMORY_UTILIZATION}" \
    --served-model-name "${SERVED_MODEL_NAME}" ${additional_args}
