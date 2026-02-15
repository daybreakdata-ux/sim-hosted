#!/usr/bin/env bash
# Generate secure keys for Vercel deployment

echo "==================================="
echo "Sim Vercel Deployment Key Generator"
echo "==================================="
echo ""
echo "Copy these values to your Vercel environment variables:"
echo ""
echo "-----------------------------------"
echo "ENCRYPTION_KEY="
openssl rand -hex 32
echo ""
echo "INTERNAL_API_SECRET="
openssl rand -hex 32
echo ""
echo "API_ENCRYPTION_KEY="
openssl rand -hex 32
echo ""
echo "BETTER_AUTH_SECRET="
openssl rand -hex 32
echo "-----------------------------------"
echo ""
echo "✓ Keys generated successfully!"
echo ""
echo "Next steps:"
echo "1. Copy these values to Vercel environment variables"
echo "2. Add your DATABASE_URL from Neon"
echo "3. Add at least one LLM API key (OpenAI, Anthropic, or Gemini)"
echo "4. Set DISABLE_AUTH=true for private deployment"
echo "5. Set NEXT_PUBLIC_APP_URL to your Vercel deployment URL"
echo ""
echo "See VERCEL_DEPLOYMENT.md for complete instructions"
