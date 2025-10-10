import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.PUBLIC_SUPABASE_ANON_KEY;

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

export interface Contract {
  id: number;
  notice_id: string;
  title: string;
  description: string | null;
  posted_date: string | null;
  department: string | null;
  awardee: string | null;
  award_amount: number | null;
  matched_ticker: string | null;
  dystopia_score: number | null;
  url: string | null;
  created_at: string;
  tweeted: boolean;
  tweeted_at: string | null;
}

export async function getLatestContracts(limit = 10): Promise<Contract[]> {
  const { data, error } = await supabase
    .from('government_contracts')
    .select('*')
    .order('created_at', { ascending: false })
    .limit(limit);

  if (error) throw error;
  return data || [];
}

export async function getTopDystopianContracts(limit = 10): Promise<Contract[]> {
  const { data, error } = await supabase
    .from('government_contracts')
    .select('*')
    .order('dystopia_score', { ascending: false })
    .limit(limit);

  if (error) throw error;
  return data || [];
}

export async function getContractsByTicker(ticker: string): Promise<Contract[]> {
  const { data, error } = await supabase
    .from('government_contracts')
    .select('*')
    .eq('matched_ticker', ticker)
    .order('posted_date', { ascending: false });

  if (error) throw error;
  return data || [];
}

export async function getTotalStats() {
  const { data, error } = await supabase
    .from('government_contracts')
    .select('award_amount, dystopia_score');

  if (error) throw error;

  const totalContracts = data?.length || 0;
  const totalValue = data?.reduce((sum, c) => sum + (c.award_amount || 0), 0) || 0;
  const avgDystopiaScore = data?.reduce((sum, c) => sum + (c.dystopia_score || 0), 0) / totalContracts || 0;

  return { totalContracts, totalValue, avgDystopiaScore };
}