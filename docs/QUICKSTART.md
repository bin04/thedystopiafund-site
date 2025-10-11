# Dystopia Fund - Quick Start Guide

## What We Just Built

You now have a fully documented, partially automated dystopia tracking and content generation system. Here's what's ready to go:

## ✅ What's Working (Production)

### Active n8n Workflows

1. **Portfolio Data Collection** (`on3Lble5Ky8klpxD`)
   - ✅ Running 3x daily (7:35am, 2:05pm, 4:30pm MT)
   - ✅ Pulls from Alpaca API
   - ✅ Stores in PostgreSQL + Supabase
   - ✅ Calculates sector performance

2. **News Scraper** (`0LXa6BgsCwwYXqD1`)
   - ✅ Active and monitoring NewsAPI
   - ✅ AI-powered filtering
   - ✅ Tweet generation

3. **Government Contract Tracker** (`sF1uCDblm3Qf1JAF`)
   - ✅ Querying SAM.gov
   - ✅ Dystopia scoring working
   - ✅ Auto-tweets high-value contracts

4. **Tweet Generator** (`PJZfCg35m3R397mk`)
   - ✅ Scheduled posting
   - ✅ Performance updates

### Infrastructure
- ✅ Website live at https://thedystopiafund.com
- ✅ GitHub repo with documentation
- ✅ Netlify auto-deploy configured
- ✅ Supabase database with RLS
- ✅ PostgreSQL schema defined

## 🚧 What Needs Completion

### Blog Post Generator (Workflow #5)

**Status:** Core structure built, saved to `/n8n-workflows/05-blog-post-generator.json`

**What's Done:**
- ✅ Weekly trigger (Saturdays 9am MT)
- ✅ Data collection from Supabase
- ✅ Portfolio analysis logic
- ✅ Contract aggregation

**What You Need to Add in n8n:**

1. **Import the workflow JSON**
   - Go to n8n UI
   - Import from `/n8n-workflows/05-blog-post-generator.json`

2. **Add AI Agent Node**
   - Type: `@n8n/n8n-nodes-langchain.agent`
   - Position: Connect after "Analyze Week Data"
   - Use the prompt template from docs/BLOG_AUTOMATION.md

3. **Add Claude Model Node**
   - Type: `@n8n/n8n-nodes-langchain.lmChatAnthropic`
   - Model: `claude-sonnet-4-20250514`
   - Temperature: 0.8
   - Max Tokens: 4000
   - Connect to AI Agent via `ai_languageModel` connection

4. **Add Format for GitHub Node** (Code)
   - Copy code from docs/BLOG_AUTOMATION.md section "Add Format Node"

5. **Add GitHub Push Node** (HTTP Request)
   - Method: PUT
   - URL: GitHub API (see BLOG_AUTOMATION.md)
   - Auth: Create GitHub credential with repo write access

6. **Add Database Log Node** (PostgreSQL)
   - SQL from docs/BLOG_AUTOMATION.md

7. **Create blog_posts table**
   ```sql
   CREATE TABLE blog_posts (
     id SERIAL PRIMARY KEY,
     date DATE UNIQUE NOT NULL,
     title TEXT NOT NULL,
     filepath TEXT NOT NULL,
     weekly_return NUMERIC(5,2),
     published_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
   );
   ```

## 📚 Documentation Structure

All docs are in `/docs/`:

- **README.md** — Project overview, thesis, portfolio breakdown
- **ARCHITECTURE.md** — Full technical architecture
- **BLOG_AUTOMATION.md** — Detailed blog workflow guide
- **QUICKSTART.md** — This file

## 🎯 Next Steps (Priority Order)

### Immediate (This Week)
1. Complete Blog Workflow #5
   - Import JSON to n8n
   - Add AI nodes (can't be automated via API)
   - Test with manual execution
   - Fix any bugs

2. Test First Blog Post
   - Run workflow manually
   - Check generated content quality
   - Verify GitHub push works
   - Confirm Netlify deployment

3. Set Up Monitoring
   - Verify ErrorFlow is catching failures
   - Set up email/Slack alerts (optional)

### Short Term (Next 2 Weeks)
4. Content Quality Tuning
   - Review AI-generated blog posts
   - Adjust temperature/prompts if needed
   - Ensure voice consistency

5. Data Visualization
   - Add charts to website
   - Portfolio performance over time
   - Contract award timeline

### Medium Term (Next Month)
6. Enhanced Analytics
   - Misery Index calculator
   - Contract→Stock correlations
   - Sector performance viz

7. Cross-Posting
   - Substack integration
   - Newsletter automation

## 🔑 Key Files & URLs

**GitHub Repo:**
- https://github.com/bin04/thedystopiafund-site

**Live Site:**
- https://thedystopiafund.com

**Twitter:**
- @DystopiaFund

**n8n Workflows:**
- Import from `/n8n-workflows/*.json`

**Database:**
- PostgreSQL schema in `/database/schema.sql`
- Supabase URL in workflow configs

## 🐛 Troubleshooting

**Workflow fails?**
- Check ErrorFlow workflow (Dw9vcss7zB87KF3h)
- Review execution logs in n8n
- Verify API credentials

**AI generates wrong format?**
- Check prompt template
- Adjust temperature (0.7-0.9 range)
- Add more specific instructions

**GitHub push fails?**
- Verify token has repo write permissions
- Check base64 encoding is working
- Ensure filepath doesn't conflict

**Netlify won't deploy?**
- Check build logs
- Verify netlify.toml configuration
- Test Astro build locally first

## 💡 Pro Tips

1. **Test Everything Manually First**
   - Use n8n's "Execute Workflow" before scheduling
   - Check each node's output
   - Verify data formats

2. **Start Conservative**
   - Begin with higher temperature (0.8) for creativity
   - Can adjust down if too chaotic
   - Can adjust up if too bland

3. **Monitor for a Week**
   - Watch first few automated posts
   - Tune prompts based on output
   - Adjust scheduling if needed

4. **Keep Voice Consistent**
   - Refer to docs/ARCHITECTURE.md for voice guidelines
   - "Data-first cynicism"
   - "Acknowledge profit, never celebrate suffering"

## 📞 Support

If you run into issues:

1. Check docs/BLOG_AUTOMATION.md for detailed workflow setup
2. Review docs/ARCHITECTURE.md for system overview
3. Look at existing workflows as examples
4. Check n8n execution logs for errors

## 🎉 When It's Working

You'll know the system is fully operational when:

- ✅ Portfolio data updates 3x daily
- ✅ News gets scraped and tweeted
- ✅ Contracts get tracked and scored
- ✅ Performance tweets go out on schedule
- ✅ **Blog posts publish every Saturday 9am**
- ✅ Website updates automatically
- ✅ Database stays in sync

## The Vision

When complete, you'll have:

**Daily:**
- Portfolio tracking (automatic)
- News monitoring (automatic)
- Tweet generation (automatic)
- Contract alerts (automatic)

**Weekly:**
- Blog post generation (automatic)
- Performance analysis (automatic)
- Dystopia highlights (automatic)

**Monthly:**
- Portfolio rebalancing (manual review)
- Content strategy adjustment (manual)
- New feature development (manual)

**The Result:**
A fully automated AI-powered dystopia tracking and commentary system that makes the uncomfortable thesis transparent: systematic human suffering generates measurable alpha.

And it does it all with sardonic wit and impeccable data visualization.

---

*Your Misery, Our Dividends.*  
*Now 80% Automated.*