# Blog Post Automation - The Dystopia Fund

## Overview

Automated weekly blog generation analyzing portfolio performance through the lens of "profiting from societal dysfunction."

## Current Workflow Status

### ✅ Completed Workflows (Production)

1. **01-Portfolio Data Collection** (Active)
   - Runs 3x daily (7:35am, 2:05pm, 4:30pm MT)
   - Pulls Alpaca positions → PostgreSQL + Supabase
   - Calculates sector performance, top gainers/losers

2. **02-News Scraper** (Active)
   - Monitors NewsAPI for dystopia-relevant news
   - AI-powered relevance filtering
   - Auto-generates tweet content

3. **03-Government Contract Tracker** (Active)
   - Queries SAM.gov for new contracts
   - Matches to portfolio companies
   - Dystopia scoring system
   - Auto-tweets high-value contracts

4. **04-Tweet Gen and Post** (Active)
   - Scheduled tweet generation
   - Portfolio performance updates
   - Sardonic commentary

### 🚧 In Development

5. **05-Blog Post Generator** (Needs completion)
   - **Status**: Core structure created, saved to `n8n-workflows/05-blog-post-generator.json`
   - **Trigger**: Weekly (Saturdays 9am MT)
   - **What's Working**: Data collection, analysis
   - **Needs**: AI content generation, GitHub push, formatting

## Workflow Design: Blog Post Generator

### Data Flow
```
Weekly Trigger (Sat 9am)
    ↓
[Parallel Queries]
    ├─ Get Portfolio Snapshots (last 7 days)
    └─ Get Government Contracts (last 7 days)
    ↓
Analyze Week's Data (Code Node)
    ↓
Generate Blog Content (AI Agent + Claude)
    ↓
Format for GitHub (Add frontmatter)
    ↓
Push to GitHub (Auto-deploy via Netlify)
    ↓
Log to Database
```

### Content Generation Prompt

```
You are the sardonic AI voice of The Dystopia Fund. 
Write "Week in Dystopia: [DATE RANGE]".

DATA:
- Weekly Return: X%
- Portfolio Value: $X
- Top Gainers/Losers: [...]
- Best/Worst Sectors: X ($X avg P/L)
- Contracts: X worth $X
- Top Dystopian Contracts: [...]

GUIDELINES:
1. Punchy opening about profiting from dysfunction
2. Dry wit - acknowledge profit, never celebrate suffering
3. Highlight cynical correlations
4. "Dystopia Highlight of the Week" section
5. Sardonic close about incentive structures
6. Markdown: ## headers, **bold** numbers
7. 800-1200 words, NO emojis
8. Voice: British wit + American directness
9. Sign off: "Your Misery, Our Dividends."
```

### Output Format

**File**: `src/pages/blog/YYYY-MM-DD-week-in-dystopia.md`

**Frontmatter**:
```yaml
---
title: "Week in Dystopia: [Date Range]"
date: YYYY-MM-DD
author: "The Dystopia Fund"
description: "Weekly analysis of profiting from societal dysfunction"
performance: "X.XX%"
layout: "../../layouts/BlogLayout.astro"
---
```

## Implementation Steps

### To Complete the Workflow:

1. **Import to n8n**:
   - Copy `/n8n-workflows/05-blog-post-generator.json`
   - Import via n8n UI

2. **Add AI Nodes** (cannot be automated via API):
   
   **AI Agent Node**:
   - Type: `@n8n/n8n-nodes-langchain.agent`
   - Position: After "Analyze Week Data"
   - Prompt: Use template above with expressions:
     ```
     {{ $json.weekRange }}
     {{ $json.weeklyReturn }}
     {{ JSON.stringify($json.topGainers) }}
     etc.
     ```
   
   **Claude Model Node**:
   - Type: `@n8n/n8n-nodes-langchain.lmChatAnthropic`
   - Model: `claude-sonnet-4-20250514`
   - Max Tokens: 4000
   - Temperature: 0.8
   - Connect to AI Agent via `ai_languageModel` connection

3. **Add Format Node** (Code):
   ```javascript
   const agentOutput = $input.first().json;
   const blogContent = agentOutput.output;
   const analysisData = $('Analyze Week Data').first().json;
   
   const now = new Date();
   const dateStr = now.toISOString().split('T')[0];
   const filename = `${dateStr}-week-in-dystopia.md`;
   const filepath = `src/pages/blog/${filename}`;
   
   const frontmatter = `---
   title: "Week in Dystopia: ${analysisData.weekRange}"
   date: ${dateStr}
   author: "The Dystopia Fund"
   description: "Weekly analysis of profiting from societal dysfunction"
   performance: "${analysisData.weeklyReturn}%"
   layout: "../../layouts/BlogLayout.astro"
   ---
   
   `;
   
   return [{
     filepath,
     content: frontmatter + blogContent,
     weekReturn: analysisData.weeklyReturn,
     weekRange: analysisData.weekRange,
     dateStr
   }];
   ```

4. **Add GitHub Push Node** (HTTP Request):
   - Method: PUT
   - URL: `https://api.github.com/repos/bin04/thedystopiafund-site/contents/{{ $json.filepath }}`
   - Auth: GitHub Token (create credential)
   - Body (JSON):
     ```json
     {
       "message": "Blog: Week in Dystopia {{ $json.weekRange }} ({{ $json.weekReturn }}%)",
       "content": "{{ $base64Encode($json.content) }}",
       "branch": "main"
     }
     ```

5. **Add Database Log Node** (PostgreSQL):
   ```sql
   INSERT INTO blog_posts 
   (date, title, filepath, weekly_return, published_at) 
   VALUES 
   ('{{ $json.dateStr }}', 
    'Week in Dystopia: {{ $json.weekRange }}', 
    '{{ $json.filepath }}', 
    {{ $json.weekReturn }}, 
    NOW()) 
   ON CONFLICT (date) DO NOTHING
   ```

6. **Create Blog Posts Table** (if not exists):
   ```sql
   CREATE TABLE IF NOT EXISTS blog_posts (
     id SERIAL PRIMARY KEY,
     date DATE UNIQUE NOT NULL,
     title TEXT NOT NULL,
     filepath TEXT NOT NULL,
     weekly_return NUMERIC(5,2),
     published_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
   );
   ```

## Database Schema Additions

### Required Table: blog_posts

Add to your PostgreSQL/Supabase:

```sql
CREATE TABLE blog_posts (
  id SERIAL PRIMARY KEY,
  date DATE UNIQUE NOT NULL,
  title TEXT NOT NULL,
  filepath TEXT NOT NULL,
  weekly_return NUMERIC(5,2),
  content_preview TEXT,
  published_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_blog_date ON blog_posts(date DESC);
```

## Content Strategy

### Weekly Blog Post Structure

**Opening** (100-150 words):
- Thesis statement about the week's "dystopian alpha"
- Overall portfolio performance in context

**Performance Analysis** (300-400 words):
- Weekly returns with sector breakdown
- Top gainers/losers with sardonic commentary
- Key correlations (e.g., "PLTR surged 8% the day ICE awarded $50M contract")

**Dystopia Highlight of the Week** (200-300 words):
- Most morally uncomfortable contract or correlation
- The numbers (award amount, stock movement)
- The uncomfortable implication

**Sector Spotlight** (150-200 words):
- Deep dive on best/worst performing sector
- Why it moved (news, contracts, general misery)

**Closing** (100-150 words):
- Sardonic observation about incentive structures
- Sign-off: "Your Misery, Our Dividends."

### Voice Guidelines

**DO**:
- Use dry British wit with American directness
- Lead with data, follow with cynical observation
- Bold key numbers for scannability
- Acknowledge the uncomfortable truth
- Use short, punchy headers

**DON'T**:
- Celebrate suffering (only acknowledge profit)
- Use emojis or excessive exclamation points
- Explain the joke (let the data speak)
- Moralize (we're reporters, not activists)
- Use hedge language ("seems to", "might be")

## Deployment Flow

```
n8n Workflow Execution
    ↓
Generate Markdown File
    ↓
Push to GitHub (main branch)
    ↓
Netlify Detects Change
    ↓
Auto-Build Astro Site
    ↓
Deploy to https://thedystopiafund.com/blog/[slug]
    ↓
Update Database Log
```

## Future Enhancements

### Phase 2: Cross-posting
- Substack API integration
- Format conversion (Astro markdown → Substack HTML)
- Auto-publish to Substack after GitHub deploy

### Phase 3: Analytics Integration
- Track which dystopia highlights get most engagement
- Correlate blog topics with Twitter reach
- A/B test sardonic vs. data-heavy approaches

### Phase 4: Interactive Elements
- Embedded portfolio performance charts
- Contract award timeline visualization
- "Misery Index" calculator widget

## Testing Checklist

Before going live:

- [ ] Test Supabase queries (7-day lookback)
- [ ] Verify data analysis calculations
- [ ] Test AI content generation (check for off-brand output)
- [ ] Validate markdown frontmatter format
- [ ] Test GitHub push (use test branch first)
- [ ] Verify Netlify auto-deploy
- [ ] Check blog post renders correctly on site
- [ ] Test database logging
- [ ] Run error workflow integration

## Troubleshooting

### Common Issues

**AI generates wrong format**:
- Check prompt template
- Verify temperature (0.8 for creativity, not too random)
- Ensure "return ONLY markdown" instruction is clear

**GitHub push fails**:
- Verify auth token has repo write permissions
- Check base64 encoding is working
- Ensure filepath doesn't already exist (or handle updates)

**Netlify doesn't deploy**:
- Check webhook is configured
- Verify build settings in netlify.toml
- Check build logs for Astro errors

## Manual Override

To manually trigger blog generation:

1. Go to n8n workflow "05-Blog Post Generator"
2. Click "Execute Workflow"
3. Monitor execution
4. If successful, check GitHub for commit
5. Wait ~2min for Netlify deploy
6. Visit https://thedystopiafund.com/blog/[date]-week-in-dystopia

## Contact & Maintenance

**Workflow Owner**: Claude (AI Agent) + Human Oversight
**Error Notifications**: Sent to ErrorFlow workflow (Dw9vcss7zB87KF3h)
**Timezone**: America/Denver (MT)
**Schedule**: Saturdays 9:00 AM

---

*Your Misery, Our Dividends.*
*Now With Automated Weekly Commentary.*