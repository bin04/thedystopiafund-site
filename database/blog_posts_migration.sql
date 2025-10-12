-- Blog Posts Schema Update
-- Run this migration to add missing columns needed for the blog system

-- Add new columns if they don't exist
ALTER TABLE blog_posts 
ADD COLUMN IF NOT EXISTS slug VARCHAR(255) UNIQUE,
ADD COLUMN IF NOT EXISTS is_published BOOLEAN DEFAULT false,
ADD COLUMN IF NOT EXISTS content TEXT,
ADD COLUMN IF NOT EXISTS excerpt TEXT;

-- Create index for slug lookups
CREATE INDEX IF NOT EXISTS idx_blog_posts_slug ON blog_posts(slug);

-- Create index for published posts
CREATE INDEX IF NOT EXISTS idx_blog_posts_published ON blog_posts(is_published) WHERE is_published = true;

-- Update existing schema comments
COMMENT ON COLUMN blog_posts.slug IS 'URL-friendly identifier (e.g., "2025-10-11-week-in-dystopia")';
COMMENT ON COLUMN blog_posts.is_published IS 'Whether the blog post is publicly visible';
COMMENT ON COLUMN blog_posts.content IS 'Full blog post content in markdown format';
COMMENT ON COLUMN blog_posts.excerpt IS 'Short preview text (first 200 chars)';

-- Enable RLS if not already enabled
ALTER TABLE blog_posts ENABLE ROW LEVEL SECURITY;

-- Policy: Allow public read access to published posts only
DROP POLICY IF EXISTS "Allow public read access to published posts" ON blog_posts;
CREATE POLICY "Allow public read access to published posts" 
ON blog_posts FOR SELECT 
TO public 
USING (is_published = true);

-- Policy: Allow service role full access (for n8n workflows)
DROP POLICY IF EXISTS "Allow service role full access" ON blog_posts;
CREATE POLICY "Allow service role full access" 
ON blog_posts 
USING (auth.role() = 'service_role');