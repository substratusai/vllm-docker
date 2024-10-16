# vLLM Docker Container Image
vLLM is a fast and easy-to-use library for LLM inference and serving.
This container image runs the OpenAI API server of vLLM.

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
  substratusai/vllm \
  --model=mistralai/Mistral-7B-Instruct-v0.1
```

## Building
```
docker build -t ghcr.io/substratusai/vllm .
```
