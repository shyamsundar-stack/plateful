"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { generateGroceryList } from "@/lib/actions/grocery-actions";

export default function GenerateGroceryButton({
  weekPlanId,
}: {
  weekPlanId: string;
}) {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const router = useRouter();

  async function handleGenerate() {
    setLoading(true);
    setError(null);
    try {
      await generateGroceryList(weekPlanId);
      router.refresh();
    } catch (err) {
      setError(
        err instanceof Error ? err.message : "Failed to generate grocery list"
      );
    } finally {
      setLoading(false);
    }
  }

  return (
    <div>
      <button
        onClick={handleGenerate}
        disabled={loading}
        className="px-6 py-3 rounded-xl bg-primary text-white font-semibold
          hover:bg-primary/90 disabled:opacity-50 disabled:cursor-not-allowed
          transition-colors shadow-sm"
      >
        {loading ? (
          <span className="flex items-center gap-2">
            <svg className="animate-spin h-4 w-4" viewBox="0 0 24 24">
              <circle
                className="opacity-25"
                cx="12"
                cy="12"
                r="10"
                stroke="currentColor"
                strokeWidth="4"
                fill="none"
              />
              <path
                className="opacity-75"
                fill="currentColor"
                d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"
              />
            </svg>
            Generating...
          </span>
        ) : (
          "🛒 Generate Grocery List"
        )}
      </button>
      {error && (
        <p className="mt-3 text-sm text-red-600 bg-red-50 rounded-lg px-3 py-2">
          {error}
        </p>
      )}
    </div>
  );
}
