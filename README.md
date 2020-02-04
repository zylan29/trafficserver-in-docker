# trafficserver-in-docker
Apache Traffic Server in Docker container

## How to use

Use `docker-compose` to build, create, start and destroy traffic server container.
```shell
# Up
docker-compose up -d

# Down
docker-compose down
```

## Auto configuration via environment variables

* `STORAGE` A list of all the files, directories, and/or hard disk partitions that make up the Traffic Server cache, separated by 1 space, its format is `STORAGE_1:-SIZE_1 STORAGE_2:-SIZE_2`. Refer to [storage.config](https://docs.trafficserver.apache.org/en/latest/admin-guide/files/storage.config.en.html) for more details.
```
# Example storage configuration
STORAGE=/cache1:-10G /cache2:-1G
```

* `REMAP` A list of mapping rules that map URL requests to specific origin servers. Refer to [remap.config](https://docs.trafficserver.apache.org/en/latest/admin-guide/files/remap.config.en.html) for more details.
```
# Example remap configuration
REMAP=orange1.org:-192.168.122.120 orange2.org:-192.168.122.172
```