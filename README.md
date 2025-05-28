# container

OpenUUP container.

## Deploying

You can deploy it with podman like so:

```bash
mkdir fileinfo packs
podman run -v ./fileinfo:/openuup/json-api/fileinfo -v ./packs:/openuup/json-api/packs -p 8080:80 quay.io/charles2/openuup:latest
```

You can also in theory use Docker.

You might need to add `:z` to each volume flag if your system uses SELinux.