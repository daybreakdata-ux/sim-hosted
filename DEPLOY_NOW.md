# 5-Minute Deployment Guide

## What You Need

1. **Neon Account** - neon.tech (free)
2. **Vercel Account** - vercel.com
3. **GitHub Repo** - This repo pushed to GitHub
4. **LLM API Key** - OpenAI, Anthropic, or Gemini
5. **Security Keys** - Generated via `openssl rand -hex 32` (4 times)

## Step-by-Step

### ⏱️ 1. Generate Security Keys (2 min)

```bash
# Copy and save these 4 values somewhere safe
echo "BETTER_AUTH_SECRET:"
openssl rand -hex 32

echo "ENCRYPTION_KEY:"
openssl rand -hex 32

echo "INTERNAL_API_SECRET:"
openssl rand -hex 32

echo "API_ENCRYPTION_KEY:"
openssl rand -hex 32
```

### ⏱️ 2. Create Neon Database (2 min)

1. Go to https://neon.tech
2. Sign up or log in
3. Create new project
4. Copy connection string (looks like: `postgresql://user:xxx@ep-xxx.neon.tech/db?sslmode=require`)

### ⏱️ 3. Deploy to Vercel (1 min)

1. Go to https://vercel.com/new
2. Click "Import Git Repository"
3. Select your GitHub repo (this one)
4. Select `main` branch
5. Click "Import"

### ⏱️ 4. Add Environment Variables <30 sec

In Vercel, add these variables:

```
DATABASE_URL = (paste the Neon connection string)
DISABLE_AUTH = true
NEXT_PUBLIC_APP_URL = (your Vercel domain, e.g., my-app.vercel.app)
BETTER_AUTH_URL = (same as above)
BETTER_AUTH_SECRET = (from step 1)
ENCRYPTION_KEY = (from step 1)
INTERNAL_API_SECRET = (from step 1)
API_ENCRYPTION_KEY = (from step 1)
OPENAI_API_KEY = (OR ANTHROPIC_API_KEY_1 OR GEMINI_API_KEY_1)
```

### ⏱️ 5. Deploy (1 min)

Click "Deploy" in Vercel and wait 3-5 minutes.

## Done! 🎉

Visit your Vercel URL and you're live. No login needed.

## Verify It Works

1. Visit your Vercel domain
2. You should see the workspace immediately
3. Create a test workflow
4. Refresh the page
5. Workflow should still be there (database working)
6. Try connecting an integration

## Common Issues

| Issue | Fix |
|-------|-----|
| Build fails | Check DATABASE_URL is set with `?sslmode=require` |
| 500 error | Check Neon database is active (not paused) |
| Can't access workspace | Set `DISABLE_AUTH=true` |

## Optional: Add Password Protection

1. Vercel Project → Settings → Deployments
2. Enable "Deployment Protection"
3. Set password
4. Share with your team

## That's It!

You now have a fully functional AI workflow builder running on Vercel with:
- ✅ No login required
- ✅ Cloud database (Neon)
- ✅ Automatic backups
- ✅ No Docker needed
- ✅ Zero setup time for users

Share the link with your team!
