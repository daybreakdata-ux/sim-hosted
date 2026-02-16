# Vercel Deployment - Complete Final Guide

This app is **100% ready for Vercel deployment** with **no user authentication** and **Neon database**.

## What's Been Cleaned Up

✅ **All Docker files removed**
- `docker-compose.local.yml` - removed
- `docker-compose.prod.yml` - removed
- `docker-compose.ollama.yml` - removed
- `docker/` folder - cleaned
- `.devcontainer/` folder - cleaned
- All Docker documentation removed

✅ **Authentication disabled by default**
- When `DISABLE_AUTH=true`, users skip login entirely
- All requests get an anonymous session
- Workspace is immediately accessible

✅ **Database configured for Neon**
- Uses `DATABASE_URL` from Neon (PostgreSQL)
- Drizzle ORM with pgvector support
- Automatic migrations on build

## Deployment Steps

### 1. Create Neon Database

1. Go to [neon.tech](https://neon.tech)
2. Create account and new project
3. Copy the connection string:
   ```
   postgresql://user:password@ep-xxx.neon.tech/dbname?sslmode=require
   ```
   **Important**: Must include `?sslmode=require`

### 2. Deploy to Vercel

#### Option A: One-Click Deploy (Recommended)

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fsimstudioai%2Fsim&env=DISABLE_AUTH,DATABASE_URL,NEXT_PUBLIC_APP_URL)

#### Option B: Manual Import

1. Go to [vercel.com/new](https://vercel.com/new)
2. Import from GitHub
3. Select branch to deploy (usually `main`)
4. Keep default build settings (uses `vercel.json`)

### 3. Set Environment Variables

In Vercel Project Settings → Environment Variables, add:

**Required Variables:**

```bash
# Database (from Neon)
DATABASE_URL="postgresql://user:pass@ep-xxx.neon.tech/dbname?sslmode=require"

# Disable Authentication
DISABLE_AUTH=true

# App URLs (replace with your Vercel domain)
NEXT_PUBLIC_APP_URL="https://your-domain.vercel.app"
BETTER_AUTH_URL="https://your-domain.vercel.app"

# Auth secrets (even though auth is disabled, these are still required)
BETTER_AUTH_SECRET="generate-with-openssl-rand-hex-32"
ENCRYPTION_KEY="generate-with-openssl-rand-hex-32"
INTERNAL_API_SECRET="generate-with-openssl-rand-hex-32"
API_ENCRYPTION_KEY="generate-with-openssl-rand-hex-32"

# Environment
NODE_ENV="production"
```

**Generate secure keys:**

```bash
# Run this 4 times to generate 4 different 32-character hex strings
openssl rand -hex 32
```

**At Least One LLM Provider (Choose One):**

```bash
# OpenAI
OPENAI_API_KEY="sk-..."

# OR Anthropic
ANTHROPIC_API_KEY_1="sk-ant-..."

# OR Google Gemini
GEMINI_API_KEY_1="..."

# OR Mistral
MISTRAL_API_KEY="..."
```

**Optional Variables:**

```bash
# Python Code Execution (E2B)
E2B_API_KEY="your-e2b-key"

# File Storage (S3)
AWS_REGION="us-east-1"
AWS_ACCESS_KEY_ID="..."
AWS_SECRET_ACCESS_KEY="..."
S3_BUCKET_NAME="..."

# Email Notifications (Resend)
RESEND_API_KEY="re_..."
FROM_EMAIL_ADDRESS="noreply@yourdomain.com"

# Search (Serper)
SERPER_API_KEY="..."

# Caching (Redis/Upstash)
REDIS_URL="redis://..."
```

### 4. Deploy

1. Click **Deploy** in Vercel
2. Wait 3-5 minutes for build to complete
3. Visit your deployment URL
4. **You're immediately logged in** - no login screen!

## Important Notes

### ✅ What Works on Vercel

- ✅ Workflow building and editing
- ✅ AI agent creation and management
- ✅ Block and edge operations
- ✅ Database persistence (Neon)
- ✅ API endpoints
- ✅ File uploads (if S3 configured, else temporary)
- ✅ Knowledge base management
- ✅ Webhook execution
- ✅ API key management
- ✅ All core workflow features

### ⚠️ Limitations on Vercel (Serverless)

- **Real-time collaboration** is limited
  - No live cursor tracking (socket.io requires persistent connections)
  - App gracefully falls back to refresh for updates
  - Still 100% functional, just less real-time
- **Long-running executions** are capped at 300 seconds (configurable)
- **Rate limiting** applies (Vercel pro accounts get higher limits)

### 🔒 Security

- **No login required** - make sure to enable Vercel password protection
- **Encrypted** - all credentials encrypted with `ENCRYPTION_KEY`
- **Database** - Neon connection requires SSL (`sslmode=require`)
- **Internal API** - Protected with `INTERNAL_API_SECRET`

## Enable Vercel Password Protection

1. Go to Vercel Project → Settings → Deployments
2. Click "Deployment Protection"
3. Enable password protection
4. Set a strong password
5. Share password with authorized users only

## Troubleshooting

### Build Fails: "DATABASE_URL not found"
- ✅ Ensure `DATABASE_URL` is set in Vercel environment variables
- ✅ Must use Neon format: `postgresql://...?sslmode=require`
- ✅ All required variables must be set before deploy

### 500 Error on First Visit
- ✅ Check Vercel Function Logs (View Logs in Vercel)
- ✅ Verify Neon database is active (not paused)
- ✅ Confirm all env vars are set
- ✅ Try refreshing page

### Database Connection Failed
- ✅ Verify connection string is correct (from Neon)
- ✅ Connection string must include `?sslmode=require`
- ✅ Ensure Neon database is not paused
- ✅ Check IP restrictions (Neon free tier has none)

### Users Can't Use Workflows
- ✅ Check `DISABLE_AUTH=true` is set
- ✅ Database migrations must have completed (check logs)
- ✅ Anonymous user must exist (auto-created on first access)

## What to Monitor

1. **Vercel Functions** - Check if any API routes are erroring
2. **Neon Database** - Monitor connections and queries
3. **Cost** - Neon free tier: 5GB storage, with usage-based billing
4. **Performance** - Vercel analytics show function duration and cold starts

## Next Steps

After deployment:

1. ✅ Test login (should redirect immediately)
2. ✅ Create a workflow
3. ✅ Add some blocks
4. ✅ Test execution
5. ✅ Check database is persisting (refresh page)
6. ✅ Share password with your team

## Update Deployments

- **Code changes**: Push to main branch → Vercel auto-deploys
- **Environment variables**: Update in Vercel → manual redeploy or wait for next push
- **Database schema**: Changes auto-migrate on deploy (via `vercel-prebuild.sh`)

## Key Files Not in Docker

This deployment uses:

- ✅ `vercel.json` - Build and function config
- ✅ `scripts/vercel-prebuild.sh` - Runs migrations
- ✅ `packages/db/drizzle.config.ts` - Database config
- ✅ `apps/sim/drizzle.config.ts` - App-level database config
- ✅ `apps/sim/lib/auth/auth.ts` - Auth configuration (with DISABLE_AUTH support)

## Full Documentation

- [VERCEL_DEPLOYMENT.md](./VERCEL_DEPLOYMENT.md) - Complete detailed guide
- [VERCEL_QUICKSTART.md](./VERCEL_QUICKSTART.md) - Quick reference
- [README.md](./README.md) - General project info

---

**Status**: ✅ Ready for production Vercel deployment
**Auth**: Disabled (DISABLE_AUTH=true)
**Database**: Neon PostgreSQL
**Real-time**: Optional socket server (graceful fallback)
**Docker**: Not required/used
