
## Building
```
docker build -t samos123/vllm .
```

## Running
```
docker run -d -p 8080:8080 --gpus=all -e MODEL=mistralai/Mistral-7B-Instruct-v0.1 samos123/vllm
```
