#!/bin/bash
#$(aws ecr get-login --no-include-email)
docker build -t circleci-dotnet .
docker tag circleci-dotnet:latest khteh/circleci-dotnet:latest
docker push khteh/circleci-dotnet:latest
