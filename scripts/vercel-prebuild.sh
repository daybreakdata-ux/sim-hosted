#!/usr/bin/env bash
# Pre-build script to run database migrations on Vercel
set -e

echo "Running database migrations..."

# Navigate to DB package directory
cd packages/db

# Run migrations using drizzle-kit
bunx drizzle-kit migrate --config=./drizzle.config.ts

echo "✓ Database migrations completed successfully "

# Return to root
cd ../..
