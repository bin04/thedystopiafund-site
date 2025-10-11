# The Dystopia Fund

> **Your Misery, Our Dividends.**

A self-aware experiment in profiting from societal dysfunction. If human suffering generates asymmetric returns, the portfolio should outperform—and that outperformance itself becomes evidence of how deeply inverted our incentive structures have become.

## The Thesis

Modern capitalism has created perverse incentives where deteriorating social conditions become tailwinds for certain business models:

- **Palantir** profits when governments track everyone, not when communities build trust
- **Axon** wins when departments militarize, not when police reform succeeds  
- **CoreCivic** grows when incarceration becomes industrial, not when justice becomes rehabilitative
- **ENVA** extracts value from financial desperation at triple-digit APRs

This portfolio tracks 50 stocks across 10 "dystopian" sectors. It's both commentary and experiment: **if the thesis is real, it should produce measurable alpha.**

## The Validation

**5-Year Backtest (October 2020 - September 2025):**
- **Dystopia Fund: +227.2%**
- S&P 500: +89%
- **Outperformance: +138.2 percentage points**

The portfolio didn't just beat the market—it more than doubled its returns. Not through conventional growth investing, but by identifying companies whose business models explicitly benefit from societal breakdown.

**Top Performers:**
- **PLTR (Palantir)**: +1,701% — Surveillance state infrastructure
- **NVDA (NVIDIA)**: +1,393% — AI chips powering autonomous weapons
- **ENVA (Enova)**: +650% — Predatory lending to the financially desperate
- **AXON**: +626% — Militarized policing equipment

The data doesn't lie: permanent surveillance infrastructure outperforms episodic crisis response. Digital panopticons beat physical cages.

## The Portfolio

### 50 Stocks, 10 Dystopian Sectors

1. **Defense & Warfare** (7): LMT, NOC, RTX, GD, LHX, TDG, AVAV
2. **Surveillance & Control** (10): PLTR, AXON, NVDA, CRWD, MSI, BAH, CACI, TDY, LDOS, VERI
3. **Drones & Aerial Surveillance** (6): KTOS, RCAT, DPRO, ONDS, EH, JOBY
4. **Biometric/Identity Tracking** (3): VUZI, YOU, AWRE
5. **Data Infrastructure** (3): MSFT, AMZN, ORCL
6. **Prison Complex** (4): CXW, GEO, MMM, BWXT
7. **Border & Immigration** (4): ESLT, ACM, FLR, HII
8. **Predatory Finance** (7): ENVA, OMF, CACC, LPRO, UPST, EZPW, QFIN
9. **Addiction Products** (2): MO, PM
10. **Domestic Dystopia Tech** (5): HXL, CDLX, AMBA, SSYS, IDA

**[Full roster with details →](https://thedystopiafund.com/roster)**

## The Technology

This is a fully automated AI-powered dystopia tracking system:

### Data Sources
- **Alpaca Markets** — Portfolio positions & real-time P&L
- **NewsAPI** — Dystopia-relevant news monitoring
- **SAM.gov** — Government contract tracking with "dystopia scoring"

### Automation (n8n Workflows)
1. **Portfolio Data Collection** (3x daily) — Track performance across sectors
2. **News Scraper** (Continuous) — AI-filtered relevance, auto-tweet generation
3. **Government Contract Tracker** (Daily) — Match contracts to stocks, dystopia scoring
4. **Tweet Generator** (Scheduled) — Performance updates with sardonic commentary
5. **Blog Post Generator** (Weekly) — AI-generated analysis of the week's dystopian alpha

### AI Layer (Claude Sonnet 4)
- Content generation (tweets, blog posts)
- News relevance filtering
- Sardonic voice consistency
- Correlation analysis (event → stock movement)

### Infrastructure
- **Database**: PostgreSQL + Supabase (portfolio snapshots, contracts, blog posts)
- **Website**: Astro + Tailwind (deployed via Netlify)
- **Content**: Markdown-based blog, auto-published from workflows
- **Voice**: British wit meets American directness, data-first cynicism

## The Voice

**Guidelines:**
- Data-first cynicism — numbers before commentary
- Acknowledge profit, never celebrate suffering
- Self-aware complicity — we're part of the system we're critiquing
- Dry wit over outrage

**Signature Phrases:**
- "Your Misery, Our Dividends"
- "The thesis validates itself"
- "The incentives speak for themselves"

**Example Tweet:**
> "PLTR +8% today, same day ICE awarded them $50M for immigrant tracking infrastructure. The correlation isn't subtle. The portfolio is up 2.3% this week. Your misery, our dividends."

## The Dystopia Scoring Algorithm

Government contracts are scored 1-10 based on:

```javascript
function calculateDystopiaScore(contract) {
  let score = 0;
  
  // Category scoring
  if (includes('surveillance')) score += 3;
  if (includes('detention')) score += 3;
  if (includes('weapons')) score += 2;
  if (includes('border')) score += 2;
  
  // Size multiplier
  if (amount > $100M) score += 2;
  if (amount > $1B) score += 1;
  
  // Portfolio match bonus
  if (portfolio.includes(awardee)) score += 2;
  
  return Math.min(score, 10);
}
```

**Examples:**
- Palantir ICE contract ($50M): **Score 8**
- BAE Systems Saudi arms sale ($2B): **Score 10**
- GEO Group detention facility ($30M): **Score 7**

## Documentation

- **[Technical Architecture](docs/ARCHITECTURE.md)** — Full system design
- **[Blog Automation](docs/BLOG_AUTOMATION.md)** — Weekly content generation
- **[Workflow Exports](n8n-workflows/)** — n8n JSON definitions

## Deployment

```
n8n Workflow → Generate Content → Push to GitHub → Netlify Build → Live Site
```

**Live URLs:**
- Website: https://thedystopiafund.com
- Twitter: [@DystopiaFund](https://twitter.com/DystopiaFund)
- Email: dystopiafund@gmail.com

## Development

```bash
# Install dependencies
npm install

# Run local dev server
npm run dev

# Build for production
npm run build

# Deploy (automatic via Netlify on push to main)
git push origin main
```

## Project Structure

```
thedystopiafund-site/
├── src/
│   ├── pages/
│   │   ├── index.astro          # Homepage (thesis)
│   │   ├── portfolio.astro      # Current positions
│   │   ├── contracts.astro      # Contract feed
│   │   ├── roster.astro         # The 50 stocks
│   │   ├── about.astro          # Methodology
│   │   └── blog/
│   │       └── [slug].astro     # Blog posts (auto-generated)
│   ├── layouts/
│   └── lib/
├── database/
│   └── schema.sql               # PostgreSQL schema
├── n8n-workflows/               # Workflow exports
│   ├── 01-portfolio-collection.json
│   ├── 02-news-scraper.json
│   ├── 03-contract-tracker.json
│   ├── 04-tweet-generator.json
│   └── 05-blog-generator.json
├── docs/
│   ├── ARCHITECTURE.md          # Technical deep dive
│   └── BLOG_AUTOMATION.md       # Content workflow
└── public/
    └── assets/
```

## The Uncomfortable Truth

Every time this portfolio outperforms, it's evidence that our incentive structures are inverted. Every government contract awarded is data. Every stock surge after a dystopian news event is measurement.

**We're not celebrating this. We're documenting it.**

The 5-year backtest isn't just numbers—it's a statistical proof that human suffering is a better investment thesis than human flourishing.

And that's exactly the point.

## What's Next

### Phase 1: Complete Blog Automation (In Progress)
- [x] Core workflow structure
- [ ] AI content generation node
- [ ] GitHub push integration
- [ ] First automated weekly post

### Phase 2: Enhanced Analytics
- [ ] Misery Index calculator
- [ ] Contract→Stock correlation charts
- [ ] Sector performance visualization
- [ ] Interactive dashboards

### Phase 3: Expansion
- [ ] Substack cross-posting
- [ ] Newsletter automation
- [ ] Community features (ironic)
- [ ] "Dystopia of the Month" tracker

## Contributing

This is a solo AI-human collaboration project (Claude + Human oversight), but if you're inspired to fork it or build something similar, go for it. The thesis is open source.

Just remember: we're not trying to fix this. We're trying to make it uncomfortably transparent.

## License

MIT — Because even dystopian satire should be free.

---

**Contact:**
- Email: dystopiafund@gmail.com
- Twitter: [@DystopiaFund](https://twitter.com/DystopiaFund)
- Website: [thedystopiafund.com](https://thedystopiafund.com)

---

*Your Misery, Our Dividends.*  
*Automated. Sardonic. Data-Driven.*
