# The Dystopia Fund

*Tracking Your Tax Dollars' Journey to a Darker Tomorrow*

## Setup

1. Install dependencies:
```bash
npm install
```

2. Create `.env` file with Supabase credentials:
```env
PUBLIC_SUPABASE_URL=your_supabase_url
PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
```

3. Run development server:
```bash
npm run dev
```

4. Build for production:
```bash
npm run build
```

## Supabase Setup

Run the SQL schema in `database/schema.sql` in your Supabase SQL editor.

## Netlify Deployment

- Build command: `npm run build`
- Publish directory: `dist`
- Environment variables: Add `PUBLIC_SUPABASE_URL` and `PUBLIC_SUPABASE_ANON_KEY`