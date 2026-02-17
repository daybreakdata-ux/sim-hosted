#!/usr/bin/env bash
# Vercel build script for sim
set -e

# Set NEXT_PUBLIC_APP_URL from VERCEL_URL if available
if [ -n "$VERCEL_URL" ]; then
  export NEXT_PUBLIC_APP_URL="https://$VERCEL_URL"
fi

# If NEXT_PUBLIC_APP_URL is still not set, fail
if [ -z "$NEXT_PUBLIC_APP_URL" ]; then
  echo "Error: NEXT_PUBLIC_APP_URL must be set either as an environment variable or VERCEL_URL must be available"
  exit 1
fi

echo "Building with NEXT_PUBLIC_APP_URL=$NEXT_PUBLIC_APP_URL"

# Run the build
bunx turbo build --filter=sim...
