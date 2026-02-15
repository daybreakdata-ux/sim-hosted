# Vercel Deployment - Quick Reference

## Minimal Required Environment Variables

```bash
# Database (from Neon)
DATABASE_URL="postgresql://user:pass@host.neon.tech/db?sslmode=require"

# Disable Authentication
DISABLE_AUTH=true

# Security Keys (generate with: bash scripts/generate-vercel-keys.sh)
ENCRYPTION_KEY="your-32-char-hex-key"
INTERNAL_API_SECRET="your-32-char-hex-key"
API_ENCRYPTION_KEY="your-32-char-hex-key"
BETTER_AUTH_SECRET="your-32-char-hex-key"

# App URLs
NEXT_PUBLIC_APP_URL="https://your-app.vercel.app"
BETTER_AUTH_URL="https://your-app.vercel.app"

# LLM Provider (at least one required)
OPENAI_API_KEY="sk-..."
# OR
ANTHROPIC_API_KEY_1="sk-ant-..."
# OR
GEMINI_API_KEY_1="..."

# Environment
NODE_ENV=production
```

## Generate Keys Locally

```bash
bash scripts/generate-vercel-keys.sh
```

## Optional: Enable Python Execution

```bash
E2B_API_KEY="your-e2b-key"  # Get from e2b.dev
```

## Security: Enable Password Protection

1. Go to Vercel Project Settings
2. Click "Deployment Protection"
3. Enable "Password Protection"
4. Set a strong password
5. Share password with authorized users only

## Deployment Steps

1. Create Neon database → Copy `DATABASE_URL`
2. Generate keys → Run `bash scripts/generate-vercel-keys.sh`
3. Deploy to Vercel → Import from GitHub
4. Add environment variables → Vercel Project Settings
5. Enable password protection → Vercel Deployment Protection
6. Visit your app → `https://your-app.vercel.app`

## Full Documentation

See [VERCEL_DEPLOYMENT.md](./VERCEL_DEPLOYMENT.md) for complete instructions.
