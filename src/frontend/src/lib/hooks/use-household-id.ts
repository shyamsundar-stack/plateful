"use client";

import { useState, useEffect } from "react";
import { createClient } from "@/lib/supabase/client";

// Fetches and caches the current user's household_id via Supabase RPC
// Call once at page level, pass down to child components
export function useHouseholdId() {
  const [householdId, setHouseholdId] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    async function fetchHouseholdId() {
      try {
        const supabase = createClient();
        const { data, error: rpcError } = await supabase.rpc(
          "get_my_household_id"
        );

        if (rpcError) {
          setError(rpcError.message);
          return;
        }

        if (!data) {
          setError("No household found for your account.");
          return;
        }

        setHouseholdId(data);
      } catch {
        setError("Failed to load household information.");
      } finally {
        setLoading(false);
      }
    }

    fetchHouseholdId();
  }, []);

  return { householdId, loading, error };
}
