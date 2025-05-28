# container

OpenUUP container.

## Deploying

```bash
podman run -v ./fileinfo:/openuup/json-api/fileinfo:z -v ./packs:/openuup/json-api/packs:z -p 8080:80 quay.io/charles2/openuup:latest
```