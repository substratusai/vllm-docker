# vLLM Docker Container Image
vLLM is a fast and easy-to-use library for LLM inference and serving.
This container image runs the OpenAI API server of vLLM.

Supports Arm64 and x86_64 architectures.

Image URLs:

- `substratusai/vllm` (Docker Hub)
- `ghcr.io/substratusai/vllm` (GitHub Container Registry)


Support the project by adding a star! ❤️

Join us on Discord:  
<a href="https://discord.gg/JeXhcmjZVm">
<img alt="discord-invite" src="https://dcbadge.vercel.app/api/server/JeXhcmjZVm?style=flat">
</a>

## Quickstart
Deploy Mistral 7B Instruct using Docker:
```bash
docker run -d -p 8080:8080 --gpus=all \
  -e MODEL=mistralai/Mistral-7B-Instruct-v0.1 \
  ghcr.io/substratusai/vllm
```

Deploy Mistral 7B Instruct using K8s:
```
kubectl apply -f https://raw.githubusercontent.com/substratusai/vllm-docker/main/k8s-deployment.yaml
```

## Configuration Options

The following configuration options are available by using environment
variables:

| Env Name    | Description |
| -------- | ------- |
| MODEL  | REQUIRED, The model ID to serve. This can be in the form of `hf_org/model` or utilize a path to point to a local model. Example value: mistralai/Mistral-7B-Instruct-v0.1    |
| SERVED_MODEL_NAME  | OPTIONAL, The model name used in the API. If not specified, the model name will be the same as the huggingface name. |
| GPU_MEMORY_UTILIZATION | OPTIONAL, the max memory allowed to be utilized, default is 0.90     |
| PORT | OPTIONAL, the port to use for serving, default is 8080     |
| QUANTIZATION | OPTIONAL, the quantization method. Choices: 'awq', 'squeezellm' |
| DTYPE | OPTIONAL, the data type for model weights. Needs to be "half" when "awq" is used |
| MAX_MODEL_LEN | OPTIONAL, model context length. By default this is automatically derived from the model. Needs to be set to something low when using awq |
| CHAT_TEMPLATE | OPTIONAL, Path to the chat template. The chat-templates directory shows which templates are available out of the box. E.g. /chat-templates/mistral.jinja |
| EXTRA_ARGS | OPTIONAL, Any additional command line arguments to pass along |

Please see the vLLM source code of [arg-utils.py](https://github.com/vllm-project/vllm/blob/main/vllm/engine/arg_utils.py) for more details.


The container image automatically detects the number of GPUs and sets
`--tensor-parallel-size` to be equal to number of GPUs available. This
is done in the `entrypoint.sh` script.

## Building
```
docker build -t ghcr.io/substratusai/vllm .
```

## Helm Chart / K8s
Please see the vLLM helm chart that uses this image: [substratusai/helm/vllm](https://github.com/substratusai/helm/tree/main/charts/vllm)
