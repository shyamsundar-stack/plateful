import { createBrowserClient } from "@supabase/ssr";

// Browser Supabase client — use in Client Components ("use client" files)
// Safe to use NEXT_PUBLIC_ keys — RLS protects all data
export function createClient() {
  return createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
  );
}
