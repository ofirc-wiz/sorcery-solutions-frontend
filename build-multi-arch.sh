#!/bin/bash
set -e

# Set variables
IMAGE_NAME="ofirc/frontend"
TAG="latest"

# Create a new builder instance if it doesn't exist
if ! docker buildx inspect multiarch-builder &>/dev/null; then
  echo "Creating new buildx builder 'multiarch-builder'"
  docker buildx create --name multiarch-builder --use
fi

# Switch to the builder
docker buildx use multiarch-builder

# Bootstrap the builder
docker buildx inspect --bootstrap

# Build and push multi-architecture image
echo "Building and pushing multi-architecture image for ${IMAGE_NAME}:${TAG}"
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t ${IMAGE_NAME}:${TAG} \
  --push \
  .

echo "Multi-architecture image built and pushed successfully!"
echo "You can verify with: docker buildx imagetools inspect ${IMAGE_NAME}:${TAG}"
