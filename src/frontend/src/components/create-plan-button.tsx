"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { createWeekPlan } from "@/lib/actions/planner-actions";
import { trackEvent } from "@/lib/actions/analytics-actions";
import { useHouseholdId } from "@/lib/hooks/use-household-id";

export default function CreatePlanButton({ monday }: { monday: string }) {
  const router = useRouter();
  const { householdId, loading: householdLoading } = useHouseholdId();
  const [creating, setCreating] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function handleCreate() {
    if (!householdId) return;
    setCreating(true);
    setError(null);
    try {
      await createWeekPlan(householdId, monday);
      trackEvent("week_plan_created", { start_date: monday }).catch(() => {});
      router.refresh();
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to create plan");
    } finally {
      setCreating(false);
    }
  }

  return (
    <div>
      <button
        onClick={handleCreate}
        disabled={creating || householdLoading || !householdId}
        className="px-6 py-3 rounded-lg bg-primary text-white font-semibold hover:bg-primary-dark disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
      >
        {creating ? "Creating..." : "Start Planning This Week"}
      </button>
      {error && (
        <p className="mt-3 text-sm text-red-600 bg-red-50 rounded-lg p-2 inline-block">
          {error}
        </p>
      )}
    </div>
  );
}
