<!-- .github/copilot-instructions.md -->
# The Dystopia Fund — Copilot instructions (short)

Purpose: give AI coding agents immediate, actionable knowledge to be productive in this repo.

- Quick summary: Astro static site (Astro + Tailwind) that reads content from Supabase/Postgres; content and automation are driven by n8n workflows in `/n8n-workflows/`; deployment is handled by Netlify (static output `dist`).

Quick start (what humans run locally)
- Install: `npm install`
- Dev server: `npm run dev` (starts Astro dev)
- Build output: `npm run build` -> `dist` (Netlify publishes `dist` per `netlify.toml`)
- Preview build: `npm run preview`

Key environment variables (important to reference exactly)
- PUBLIC_SUPABASE_URL — used by client and server code (import.meta.env)
- PUBLIC_SUPABASE_ANON_KEY — public anon key used by the site (read-only)

Where to look (high-value files / directories)
- `src/lib/supabase.ts` — central Supabase client and helper functions (getLatestContracts, getTopDystopianContracts, getContractsByTicker, getTotalStats). Use these functions when you need DB-backed contract data.
- `src/pages/blog/[slug].astro` — dynamic blog route. Important: `getStaticPaths()` queries `blog_posts` with `is_published = true` to generate pages at build time. If a post isn't appearing, check `is_published` and `slug` in Supabase.
- `src/layouts/Layout.astro`, `src/layouts/BlogLayout.astro` — site layout and common UI patterns.
- `n8n-workflows/` — exported n8n JSON workflows. These orchestrate data collection (Alpaca, NewsAPI, SAM.gov) and content generation. Treat them as authoritative for automation behavior; prefer updating n8n flows in the n8n UI and re-exporting JSON rather than hand-editing unless necessary.
- `database/` — `schema.sql`, `blog_posts.sql`, `blog_posts_migration.sql` show DB shape. Use them to understand the expected column names and types.
- `netlify.toml` — Netlify build and publish configuration (`command = "npm run build"`, `publish = "dist"`).
- `package.json` — scripts: `dev`, `build`, `preview`.
- `docs/ARCHITECTURE.md` and `docs/BLOG_AUTOMATION.md` — higher-level system diagrams and workflow details (read before changing automation).

Important patterns & conventions (project-specific)
- Public env var prefix: any env variables that should be available client-side are prefixed with `PUBLIC_` and consumed with `import.meta.env.PUBLIC_*` (see `supabase.ts` and `src/pages/blog/[slug].astro`).
- Data-first content: blog posts and contract feeds are canonical in the DB. The repo's Markdown files under `src/pages/blog/` are not the primary source of truth — the Supabase `blog_posts` table is. n8n workflows push content into that table and then GitHub+Netlify build publishes the site.
- Static generation: blog pages are generated at build time. When adding or updating a post in the DB, trigger a new build to publish changes.
- Read-only client keys: The site intentionally uses the Supabase anon key (`PUBLIC_SUPABASE_ANON_KEY`) for read access. Do not replace with a service key in client-facing code.

Code examples (copyable references from the repo)
- getStaticPaths usage (blog generation):

  - The code maps published slugs to params; ensure `is_published = true` for posts to be built.

- Supabase helper functions:
  - `getLatestContracts(limit = 10)` — returns latest rows from `government_contracts`.
  - `getTopDystopianContracts(limit = 10)` — ordered by `dystopia_score` desc.
  - `getContractsByTicker(ticker)` — query by `matched_ticker`.

Developer workflows and debugging pointers
- Local dev: set a `.env` with `PUBLIC_SUPABASE_URL` and `PUBLIC_SUPABASE_ANON_KEY` (Astro reads `import.meta.env`). Then run `npm run dev`.
- Inspect DB: use Supabase UI or psql against the database defined by `database/schema.sql` to see `blog_posts` and `government_contracts` tables.
- Debug build issues: check Netlify build logs (Netlify auto-builds on push to `main`) — `netlify.toml` tells Netlify to run `npm run build` and publish `dist`.
- Debug runtime: browser devtools for client errors; server-side errors appear in the terminal running `npm run dev`.
- n8n debugging: check the n8n instance's execution logs; n8n workflows live in `n8n-workflows/` as JSON exports.

Do / Don't (short)
- Do: prefer DB-first edits for content (insert/update `blog_posts`), confirm `is_published` and `slug`.
- Do: use helper functions in `src/lib/supabase.ts` when querying contract/blog data.
- Don't: add private keys to client code. Keep non-public secrets in n8n credentials, Netlify environment variables, or a secrets manager.
- Don't: rely on local Markdown files as the canonical blog source — the site uses Supabase table data for published blog content.

Edge cases & gotchas
- If a blog post doesn't render: verify `is_published = true`, `slug` is unique, and `published_at` exists. `getStaticPaths()` only returns published slugs.
- Searching for trending/alerts: the `government_contracts` table contains `dystopia_score` and `matched_ticker`. Use `getTopDystopianContracts()` to fetch highlights.
- Netlify publishes `dist` (not `public/`); static pages are produced by Astro into `dist` during build.

If something's unclear or you need more detail, tell me which section you want expanded (DB schema, n8n workflow mapping, or local env setup) and I'll iterate.
