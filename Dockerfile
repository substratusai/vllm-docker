ARG VERSION=v0.5.3.post1
FROM vllm/vllm-openai:${VERSION}
ENV PORT 8080
COPY chat-templates /chat-templates
COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT [ "entrypoint.sh" ]
