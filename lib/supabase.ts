import { createClient } from "@supabase/supabase-js";

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

if (!supabaseUrl) throw new Error("Faltou a URL do Supabase no .env.local");
if (!supabaseAnonKey) throw new Error("Faltou a Key do Supabase no .env.local");

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

export type Game = {
  id: number;
  name: string;
  genre: string;
  platform: string;
  release_year: number;
  description: string;
  image_url: string;
  rating?: number;
  studio_id?: number | null;
  studios?: { name: string } | null;
};