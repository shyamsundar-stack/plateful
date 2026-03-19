import Header from "@/components/header";
import AnalyticsDashboard from "@/components/analytics-dashboard";
import { fetchAnalyticsSummary } from "@/lib/actions/analytics-dashboard-actions";

export default async function AnalyticsPage() {
  let error: string | null = null;
  let summary = null;

  try {
    summary = await fetchAnalyticsSummary();
  } catch (err) {
    error = err instanceof Error ? err.message : "Failed to load analytics";
  }

  return (
    <div className="min-h-screen bg-cream">
      <Header />
      <main className="max-w-5xl mx-auto px-4 py-6">
        <div className="mb-6">
          <h2 className="text-2xl font-bold text-ink">Analytics</h2>
          <p className="text-sm text-ink-muted mt-1">
            Your household cooking insights at a glance
          </p>
        </div>

        {error || !summary ? (
          <div className="text-center py-16">
            <span className="text-5xl">📊</span>
            <h3 className="text-lg font-semibold text-ink mt-4">
              {error || "No analytics available"}
            </h3>
            <p className="text-ink-muted mt-2 text-sm">
              Start planning meals to see your cooking insights here.
            </p>
          </div>
        ) : (
          <AnalyticsDashboard summary={summary} />
        )}
      </main>
    </div>
  );
}
