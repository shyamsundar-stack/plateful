"use client";

import type { AnalyticsSummary } from "@/lib/actions/analytics-dashboard-actions";

type AnalyticsDashboardProps = {
  summary: AnalyticsSummary;
};

function StatCard({
  label,
  value,
  icon,
  color = "text-primary",
}: {
  label: string;
  value: string | number;
  icon: string;
  color?: string;
}) {
  return (
    <div className="bg-surface rounded-xl border border-ink-light/10 p-4 flex items-start gap-3">
      <span className="text-2xl">{icon}</span>
      <div>
        <p className={`text-2xl font-bold ${color}`}>{value}</p>
        <p className="text-xs text-ink-muted mt-0.5">{label}</p>
      </div>
    </div>
  );
}

export default function AnalyticsDashboard({ summary }: AnalyticsDashboardProps) {
  return (
    <div className="space-y-6">
      {/* Primary Stats Grid */}
      <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-3">
        <StatCard
          icon="📖"
          label="Total Recipes"
          value={summary.totalRecipes}
          color="text-primary"
        />
        <StatCard
          icon="✅"
          label="Active Recipes"
          value={summary.activeRecipes}
          color="text-active"
        />
        <StatCard
          icon="❤️"
          label="Favorites"
          value={summary.favoriteRecipes}
          color="text-red-500"
        />
        <StatCard
          icon="📚"
          label="Library Imports"
          value={summary.libraryImports}
          color="text-secondary"
        />
        <StatCard
          icon="🍽️"
          label="Meals Planned"
          value={summary.mealsPlanned}
          color="text-primary-dark"
        />
        <StatCard
          icon="🛒"
          label="Grocery Lists"
          value={summary.groceryListsGenerated}
          color="text-accent-dark"
        />
        <StatCard
          icon="🤖"
          label="Auto-fills Used"
          value={summary.autoFillCount}
          color="text-secondary-dark"
        />
        <StatCard
          icon="🔥"
          label="Week Streak"
          value={summary.cookingStreak > 0 ? `${summary.cookingStreak}w` : "—"}
          color="text-accent"
        />
      </div>

      {/* Top Recipes + Favorite Cuisines */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        {/* Top Recipes */}
        <div className="bg-surface rounded-xl border border-ink-light/10 p-4">
          <h3 className="text-sm font-bold text-ink flex items-center gap-2 mb-3">
            <span>🏆</span> Most Cooked Recipes
          </h3>
          {summary.topRecipes.length === 0 ? (
            <p className="text-xs text-ink-muted italic">
              No recipes cooked yet. Start planning meals!
            </p>
          ) : (
            <ol className="space-y-2">
              {summary.topRecipes.map((recipe, i) => (
                <li key={recipe.title} className="flex items-center gap-2">
                  <span className="flex-shrink-0 w-5 h-5 rounded-full bg-primary/10 text-primary text-xs font-bold flex items-center justify-center">
                    {i + 1}
                  </span>
                  <span className="text-sm text-ink truncate flex-1">
                    {recipe.title}
                  </span>
                  <span className="text-xs text-ink-muted font-medium">
                    {recipe.count}x
                  </span>
                </li>
              ))}
            </ol>
          )}
        </div>

        {/* Favorite Cuisines */}
        <div className="bg-surface rounded-xl border border-ink-light/10 p-4">
          <h3 className="text-sm font-bold text-ink flex items-center gap-2 mb-3">
            <span>🌍</span> Top Cuisines
          </h3>
          {summary.favoriteCuisines.length === 0 ? (
            <p className="text-xs text-ink-muted italic">
              No cuisine data yet. Add recipes with cuisines!
            </p>
          ) : (
            <div className="space-y-2">
              {summary.favoriteCuisines.map((c) => {
                const maxCount = summary.favoriteCuisines[0]?.count ?? 1;
                const pct = Math.round((c.count / maxCount) * 100);
                return (
                  <div key={c.cuisine}>
                    <div className="flex items-center justify-between mb-1">
                      <span className="text-sm text-ink capitalize">{c.cuisine}</span>
                      <span className="text-xs text-ink-muted">{c.count}</span>
                    </div>
                    <div className="h-1.5 bg-cream rounded-full overflow-hidden">
                      <div
                        className="h-full bg-primary rounded-full transition-all"
                        style={{ width: `${pct}%` }}
                      />
                    </div>
                  </div>
                );
              })}
            </div>
          )}
        </div>
      </div>

      {/* Household info */}
      <div className="bg-cream/50 rounded-xl p-4 text-center">
        <p className="text-xs text-ink-muted">
          Household with <span className="font-semibold text-ink">{summary.totalMembers}</span> member{summary.totalMembers !== 1 ? "s" : ""}
        </p>
      </div>
    </div>
  );
}
