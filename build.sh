#!/bin/bash
set -e

cd "$(readlink -f "$(dirname "$BASH_SOURCE")")"

base='psytonx/busybox-noroot'

set -x
docker build -t "$base-builder" -f "Dockerfile.builder" .
docker run --rm "$base-builder" tar cC rootfs . | xz -z9 > "busybox.tar.xz"
docker build -t "$base" .
docker run --rm "$base" sh -xec 'true'
docker run --rm "$base" ping -c 1 google.com
docker run --rm "$base" wget https://google.com
