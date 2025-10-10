-- Government Contracts Table
CREATE TABLE government_contracts (
  id SERIAL PRIMARY KEY,
  notice_id VARCHAR(255) UNIQUE NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  posted_date DATE,
  department TEXT,
  awardee TEXT,
  award_amount NUMERIC(15, 2),
  matched_ticker VARCHAR(10),
  dystopia_score INTEGER,
  url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  tweeted BOOLEAN DEFAULT FALSE,
  tweeted_at TIMESTAMP WITH TIME ZONE
);

-- Index for faster queries
CREATE INDEX idx_dystopia_score ON government_contracts(dystopia_score DESC);
CREATE INDEX idx_posted_date ON government_contracts(posted_date DESC);
CREATE INDEX idx_matched_ticker ON government_contracts(matched_ticker);
CREATE INDEX idx_department ON government_contracts(department);

-- Enable Row Level Security (RLS) - allow public read access
ALTER TABLE government_contracts ENABLE ROW LEVEL SECURITY;

-- Policy: Allow public read access
CREATE POLICY "Allow public read access" 
ON government_contracts FOR SELECT 
TO public 
USING (true);