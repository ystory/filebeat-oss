# filebeat-oss: ARM64 Docker Image for OpenSearch

This project builds and deploys a filebeat-oss Docker image for the ARM64 architecture. Filebeat 7.12.1 is used because
it is the last version compatible with OpenSearch.

Please refer to
the [Compatibility Matrix for Beats](https://opensearch.org/docs/latest/tools/index/#compatibility-matrix-for-beats) on
the OpenSearch documentation for information on the compatibility between Filebeat versions and OpenSearch.

## Get this image
To use this image, you can pull it from Docker Hub by running the following command:

```bash
docker pull ystory/filebeat-oss:latest
```
