# Deploying Sim to Vercel (Private Deployment)

This guide shows how to deploy Sim to Vercel with Neon PostgreSQL, without user authentication for private deployments.

## Prerequisites

1. **Vercel Account**: Sign up at [vercel.com](https://vercel.com)
2. **Neon Database**: Create a database at [neon.tech](https://neon.tech) (free tier available)
3. **GitHub Repository**: Fork or clone this repository
4. **LLM API Keys**: At least one (OpenAI, Anthropic, or Gemini)

## Quick Start

### 1. Database Setup (Neon)

1. Go to [neon.tech](https://neon.tech) and create an account
2. Create a new project
3. Copy the connection string (it looks like: `postgresql://user:password@ep-...neon.tech/dbname?sslmode=require`)
4. Keep this handy for the next step

### 2. Deploy to Vercel

#### Option A: Deploy with Button

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/simstudioai/sim)

#### Option B: Manual Deployment

1. Go to [vercel.com/new](https://vercel.com/new)
2. Import your Git repository
3. Configure the build settings:
   - **Framework Preset**: Other
   - **Root Directory**: `.` (leave default)
   - **Build Command**: Leave default (uses vercel.json)
   - **Output Directory**: Leave default (uses vercel.json)

### 3. Configure Environment Variables

In your Vercel project settings, add these environment variables:

#### Required Variables

```bash
# Database
DATABASE_URL="postgresql://your-neon-connection-string"

# Authentication (Disabled for private deployment)
DISABLE_AUTH=true
BETTER_AUTH_SECRET="any-32-character-string-here-xxxxxxxxx"
BETTER_AUTH_URL="https://your-app.vercel.app"

# App URL (replace with your actual Vercel URL)
NEXT_PUBLIC_APP_URL="https://your-app.vercel.app"

# Security Keys (generate these securely!)
ENCRYPTION_KEY="run-openssl-rand-hex-32-to-generate"
INTERNAL_API_SECRET="run-openssl-rand-hex-32-to-generate"
API_ENCRYPTION_KEY="run-openssl-rand-hex-32-to-generate"

# Environment
NODE_ENV=production
```

#### Generate Secure Keys

Run these commands locally to generate secure keys:

```bash
# For ENCRYPTION_KEY
openssl rand -hex 32

# For INTERNAL_API_SECRET
openssl rand -hex 32

# For API_ENCRYPTION_KEY
openssl rand -hex 32

# For BETTER_AUTH_SECRET (even though auth is disabled, it's still required)
openssl rand -hex 32
```

#### Add LLM Provider Keys

Add at least one LLM provider API key:

```bash
# OpenAI
OPENAI_API_KEY="sk-..."

# OR Anthropic
ANTHROPIC_API_KEY_1="sk-ant-..."

# OR Google Gemini
GEMINI_API_KEY_1="..."
```

### 4. Deploy

1. Click "Deploy" in Vercel
2. Wait for the build to complete (usually 3-5 minutes)
3. Once deployed, visit your app URL

## Optional Configuration

### Python Code Execution (E2B)

By default, only JavaScript code execution is available. To enable Python:

1. Sign up at [e2b.dev](https://e2b.dev)
2. Get your API key
3. Add to Vercel environment variables:
```bash
E2B_API_KEY="your-e2b-api-key"
```

### File Storage (AWS S3)

For file uploads and storage, configure AWS S3:

```bash
AWS_REGION="us-east-1"
AWS_ACCESS_KEY_ID="your-access-key"
AWS_SECRET_ACCESS_KEY="your-secret-key"
S3_BUCKET_NAME="your-bucket-name"
```

Without S3, files will be stored temporarily and may be lost between deployments.

### Email Notifications (Resend)

To send email notifications:

```bash
RESEND_API_KEY="re_..."
FROM_EMAIL_ADDRESS="noreply@yourdomain.com"
```

Without this, emails will be logged to the console.

### Enhanced Search

For better search capabilities:

```bash
# Google Serper API
SERPER_API_KEY="your-key"

# Exa AI
EXA_API_KEY="your-key"
```

### Redis (Optional - for multi-region deployments)

If you need caching or multi-region support:

```bash
# Use Upstash Redis (free tier available)
REDIS_URL="redis://username:password@host:port"
```

The app gracefully falls back to PostgreSQL when Redis is not configured.

## Updating Your Deployment

### Environment Variables

1. Go to your Vercel project settings
2. Navigate to "Environment Variables"
3. Add or update variables
4. Redeploy for changes to take effect

### Code Updates

Vercel automatically redeploys when you push to your Git repository's main branch.

## Troubleshooting

### Build Fails

**Issue**: Build fails with "DATABASE_URL not found"
**Solution**: Ensure DATABASE_URL is set in environment variables and includes `?sslmode=require` for Neon

**Issue**: Build fails with migration errors
**Solution**: Check that your Neon database is accessible and not paused (Neon free tier pauses after inactivity)

### Runtime Errors

**Issue**: 500 errors on first visit
**Solution**: 
1. Check Vercel Function Logs
2. Ensure all required environment variables are set
3. Verify DATABASE_URL is correct
4. Make sure Neon database is active (not paused)

**Issue**: "Failed to connect to database"
**Solution**: 
1. Verify Neon database is running
2. Check if IP restrictions are configured (Neon doesn't have IP restrictions on free tier)
3. Ensure connection string includes `?sslmode=require`

### Feature Limitations

**Python Code Execution**: Requires E2B API key (optional)
**File Uploads**: Requires S3 or similar storage (optional)
**Email**: Requires Resend or similar email service (optional)
**Multi-region/Caching**: Requires Redis (optional)

All these features gracefully degrade if not configured - the app will still work for core functionality.

## Security Notes

Since you're disabling authentication with `DISABLE_AUTH=true`:

1. **Do NOT expose this publicly** - Use Vercel's password protection or IP allowlisting
2. **Enable Vercel Protection**: Go to Project Settings → Deployment Protection
3. **Use Vercel Password Protection** for easy access control
4. **Or use Vercel IP Allowlisting** to restrict access to specific IPs

### Enable Vercel Password Protection

1. Go to your project settings in Vercel
2. Navigate to "Deployment Protection"  
3. Enable "Password Protection"
4. Set a password
5. Share the password with authorized users

## Performance Optimization

### Function Timeout

The `vercel.json` configuration sets API routes to 300 seconds (5 minutes) maximum. For longer workflows, consider:

1. Using Vercel Pro (60-second timeout)
2. Implementing async job processing
3. Breaking workflows into smaller chunks

### Cold Starts

Vercel serverless functions may experience cold starts. To minimize:

1. Keep your deployment active with periodic pings
2. Consider Vercel Pro for faster cold starts
3. Use Vercel's Edge Functions for frequently accessed routes (advanced)

## Cost Considerations

### Vercel Free Tier Limitations

- 100GB bandwidth/month
- 100 hours serverless function execution time/month
- 6000 build minutes/month

For production use, consider Vercel Pro ($20/month).

### Neon Free Tier Limitations

- 0.5GB storage
- Compute pauses after 5 minutes of inactivity
- 1 project

For production use, consider Neon Pro ($19/month).

## Next Steps

1. **Test Your Deployment**: Visit your Vercel URL and ensure the app loads
2. **Create Your First Workflow**: Build a simple workflow to test functionality
3. **Configure OAuth** (optional): Set up OAuth providers for integrations
4. **Monitor Usage**: Check Vercel dashboard for function executions and errors
5. **Set Up Alerts**: Configure Vercel to notify you of deployment failures

## Support

- **Documentation**: [docs.sim.ai](https://docs.sim.ai)
- **Discord**: [Join our Discord](https://discord.gg/Hr4UWYEcTT)
- **GitHub**: [Report issues](https://github.com/simstudioai/sim/issues)

## Summary Checklist

- [ ] Neon database created and connection string copied
- [ ] Vercel project created from GitHub repository
- [ ] Environment variables configured (DATABASE_URL, DISABLE_AUTH, security keys)
- [ ] At least one LLM API key added
- [ ] Deployment successful
- [ ] App accessible at Vercel URL
- [ ] Password protection enabled (for private deployment)
- [ ] First workflow created and tested
