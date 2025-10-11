# The Dystopia Fund - Technical Architecture

## Philosophy

> "If capitalism makes misery profitable, we might as well be honest about it."

This is a performance art piece masquerading as a trading system. Every component is designed to make the uncomfortable thesis transparent: **systematic human suffering generates measurable alpha**.

## System Overview

```
                    ┌──────────────────┐
                    │   Data Sources      │
                    └────────┬─────────┘
                             │
         ┌───────────┼────────────┐
         │               │               │
    ┌────┴────┐     ┌────┴────┐     ┌────┴────┐
    │ Alpaca  │     │ NewsAPI │     │ SAM.gov │
    │ Trading │     │  News   │     │Contract│
    └────┬────┘     └────┬────┘     └────┬────┘
         │               │               │
         └───────────┬────────────┘
                       │
                 ┌─────┴─────┐
                 │ n8n Engine │
                 │ Workflows  │
                 └─────┬─────┘
                       │
         ┌───────────┼──────────┐
         │               │              │
    ┌────┴────┐     ┌────┴────┐    ┌────┴────┐
    │  PG/    │     │ Claude  │    │ GitHub  │
    │Supabase│     │ Sonnet4 │    │ + Netlfy│
    └─────────┘     └─────────┘    └────┬────┘
                                            │
                                      ┌─────┴─────┐
                                      │   Astro    │
                                      │ Website   │
                                      └───────────┘
```

## Core Components

### 1. Data Sources

**Alpaca Markets API** (Paper Trading)
- Portfolio positions and valuations
- Real-time P&L tracking
- 50-stock dystopia portfolio
- 3x daily snapshots

**NewsAPI**
- Keyword monitoring: surveillance, defense contracts, border enforcement
- AI-filtered for relevance
- Correlation tracking (news event → stock movement)

**SAM.gov (Government Contracts)**
- Federal contract awards
- Match to portfolio companies
- Dystopia scoring algorithm
- Public evidence of profit from dysfunction

### 2. Orchestration Layer (n8n)

**Active Workflows:**

1. **Portfolio Data Collection** (3x daily)
   - Pulls positions from Alpaca
   - Calculates sector performance
   - Stores in PostgreSQL + Supabase

2. **News Scraper** (Continuous)
   - Monitors NewsAPI
   - AI relevance filtering
   - Auto-tweet generation

3. **Government Contract Tracker** (Daily)
   - Queries SAM.gov
   - Dystopia scoring
   - Auto-tweets high-value contracts

4. **Tweet Generator** (Scheduled)
   - Performance updates
   - Sardonic commentary

5. **Blog Post Generator** (Weekly - In Development)
   - Weekly analysis
   - AI-generated content
   - Auto-publish to website

### 3. AI Layer (Claude Sonnet 4)

**Use Cases:**
- Content generation (tweets, blog posts)
- News relevance filtering
- Voice consistency
- Correlation analysis

**Voice Guidelines:**
- Data-first cynicism
- Never celebrate suffering
- British wit + American directness
- Self-aware complicity

### 4. Data Storage

**PostgreSQL/Supabase:**
```sql
-- Portfolio tracking
portfolio_snapshots (
  timestamp, total_value, daily_pl,
  top_gainers[], sector_performance[]
)

-- Dystopia scoring
government_contracts (
  notice_id, awardee, award_amount,
  matched_ticker, dystopia_score,
  tweeted BOOLEAN
)

-- Content tracking
blog_posts (
  date, title, weekly_return,
  filepath, published_at
)
```

### 5. Website (Astro + Tailwind)

**Pages:**
- `/` - Thesis statement
- `/portfolio` - Current positions
- `/contracts` - Contract feed
- `/roster` - The 50 stocks
- `/blog` - Weekly analysis
- `/about` - Methodology

**Deployment:**
```
n8n → GitHub → Netlify → Live Site
```

## The 50-Stock Portfolio

### Sector Breakdown

**Defense & Warfare** (7)
- LMT, NOC, RTX, GD, LHX, TDG, AVAV

**Surveillance & Control** (10)
- PLTR, AXON, NVDA, CRWD, MSI, BAH, CACI, TDY, LDOS, VERI

**Drones & Aerial** (6)
- KTOS, RCAT, DPRO, ONDS, EH, JOBY

**Biometric/Identity** (3)
- VUZI, YOU, AWRE

**Data Infrastructure** (3)
- MSFT, AMZN, ORCL

**Prison Complex** (4)
- CXW, GEO, MMM, BWXT

**Border & Immigration** (4)
- ESLT, ACM, FLR, HII

**Predatory Finance** (7)
- ENVA, OMF, CACC, LPRO, UPST, EZPW, QFIN

**Addiction Products** (2)
- MO, PM

**Domestic Dystopia** (5)
- HXL, CDLX, AMBA, SSYS, IDA

### Performance (5-Year Backtest)

- **Dystopia Fund: +227.2%**
- S&P 500: +89%
- **Outperformance: +138.2pp**

**Thesis Validation:** Systematic misery extraction outperformed conventional investing by 2x.

## Dystopia Scoring Algorithm

```javascript
function calculateDystopiaScore(contract) {
  let score = 0;
  
  // Category scoring
  if (includes('surveillance')) score += 3;
  if (includes('detention')) score += 3;
  if (includes('weapons')) score += 2;
  if (includes('border')) score += 2;
  
  // Size multiplier
  if (amount > 100M) score += 2;
  if (amount > 1B) score += 1;
  
  // Portfolio match
  if (portfolio.includes(awardee)) score += 2;
  
  return Math.min(score, 10);
}
```

**Examples:**
- Palantir ICE contract: **Score 8**
- BAE Saudi arms sale: **Score 10**
- GEO detention facility: **Score 7**

## Voice & Content Guidelines

### The Dystopia Fund Voice

**DO:**
- Lead with data, follow with cynicism
- Acknowledge profit, never celebrate suffering
- Use dry wit over outrage
- Maintain self-aware complicity

**DON'T:**
- Moralize or preach
- Use emojis or exclamation points
- Explain the joke
- Offer false hope

**Signature Phrases:**
- "Your Misery, Our Dividends"
- "The thesis validates itself"
- "The incentives speak for themselves"

### Content Formats

**Twitter** (Daily)
- Performance + observation (280 chars)
- Contract alerts
- Correlations

**Blog** (Weekly)
- 800-1200 words
- Performance analysis
- "Dystopia Highlight"
- Sector deep dive

**Website** (Static)
- Thesis explanation
- Methodology
- No sugar-coating

## Error Handling

**ErrorFlow Workflow:**
- Captures failures
- Logs to database
- (Future: alerts)

**Common Failures:**
- API rate limits
- Quota exceeded
- Push conflicts
- AI generation errors

## Security

**API Keys** (n8n credentials):
- Alpaca (paper trading)
- Supabase (public read)
- Claude API
- GitHub (write)
- Twitter API

**Risk Profile:**
- Low stakes (no real money)
- Reputation risk (satire)
- API abuse prevention

## Development Workflow

```bash
# Local dev
cd thedystopiafund-site
npm run dev

# Database
psql -h [host] -U [user] -d dystopiafund
```

**Deployment:**
1. Push to main
2. Netlify auto-builds
3. Live in ~2 min

## Future Roadmap

### Phase 1: Complete Blog (In Progress)
- [ ] Finish workflow #5
- [ ] Test AI generation
- [ ] First automated post

### Phase 2: Enhanced Analytics
- [ ] Misery Index calculator
- [ ] Contract→Stock correlations
- [ ] Interactive charts
- [ ] Sector performance viz

### Phase 3: Cross-posting
- [ ] Substack integration
- [ ] Format conversion
- [ ] Auto-publish

### Phase 4: Community
- [ ] Newsletter signup
- [ ] Comment system (ironic)
- [ ] "Dystopia of the Month" voting

### Phase 5: Meta Layer
- [ ] Track which dystopian events = most alpha
- [ ] Predict next dystopia opportunities
- [ ] "Misery Futures" (satirical)

## Monitoring

**Current:**
- n8n execution logs
- PostgreSQL logs
- Netlify builds

**Future:**
- Grafana dashboards
- Performance metrics
- Content engagement

## Key Repositories

- **Website**: `bin04/thedystopiafund-site`
- **Workflows**: `/n8n-workflows/` (JSON exports)
- **Docs**: `/docs/` (this file)

## Deployment URLs

- **Production**: https://thedystopiafund.com
- **Twitter**: @DystopiaFund
- **Email**: dystopiafund@gmail.com

## Contact

**Workflow Owner**: Claude (AI) + Human Oversight
**Error Notifications**: ErrorFlow (Dw9vcss7zB87KF3h)
**Timezone**: America/Denver (MT)

---

## The Uncomfortable Truth

Every time this portfolio outperforms, it's evidence that our incentive structures are inverted. Every government contract awarded to a portfolio company is data. Every stock surge after a dystopian news event is measurement.

We're not celebrating this. We're documenting it.

The 5-year backtest isn't just numbers—it's a statistical proof that human suffering is a better investment thesis than human flourishing.

And that's exactly the point.

---

*Your Misery, Our Dividends.*  
*Now With Full Automation.*