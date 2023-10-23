# vLLM Docker Container Image
vLLM is a fast and easy-to-use library for LLM inference and serving.
This container image runs the OpenAI API server of vLLM.

The following configuration options are available by using environment
variables:

| Env Name    | Description |
| -------- | ------- |
| MODEL  | REQUIRED, The model ID to serve. This can be in the form of `hf_org/model` or utilize a path to point to a local model. Example value: mistralai/Mistral-7B-Instruct-v0.1    |
| GPU_MEMORY_UTILIZATION | OPTIONAL, the max memory allowed to be utilized, default is 0.85     |
| PORT | OPTIONAL, the port to use for serving, default is 8080     |


The container image automatically detects the number of GPUs and sets
`--tensor-parallel-size` to be equal to number of GPUs available. The
`gpu-count.py` script is used to detect number of GPUs.

## Building
```
docker build -t ghcr.io/substratusai/vllm .
```

## Running
```
docker run -d -p 8080:8080 --gpus=all \
  -e MODEL=mistralai/Mistral-7B-Instruct-v0.1 \
  ghcr.io/substratusai/vllm
```