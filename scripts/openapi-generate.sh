#!/usr/bin/env bash

# Generate go types from the openapi spec

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
docker run --rm \
  -v "${SCRIPT_DIR}/../api/api.openapi.yaml:/local/openapi.yaml" \
  -v "${SCRIPT_DIR}/../gen:/local/gen" openapitools/openapi-generator-cli generate \
  -i /local/openapi.yaml \
  -g go-server \
  -o /local/gen -p onlyInterfaces=true -p outputAsLibrary=true
