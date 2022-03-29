#!/usr/bin/env bash
VERSION=0.0.1
docker build --no-cache -t simple-spring-app-in-k8s-testing-debug:${VERSION} .
