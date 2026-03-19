export default function PlannerLoading() {
  return (
    <div className="min-h-screen bg-cream">
      {/* Header skeleton */}
      <div className="sticky top-0 z-50 bg-surface border-b border-accent/30">
        <div className="max-w-5xl mx-auto px-4 py-3 flex items-center justify-between">
          <div className="h-7 w-32 bg-ink-light/10 rounded animate-pulse" />
          <div className="h-7 w-20 bg-ink-light/10 rounded animate-pulse" />
        </div>
      </div>

      <main className="max-w-6xl mx-auto px-4 py-6">
        {/* Week navigator skeleton */}
        <div className="flex items-center justify-center gap-4 mb-6">
          <div className="h-9 w-9 bg-ink-light/10 rounded-lg animate-pulse" />
          <div className="h-6 w-48 bg-ink-light/10 rounded animate-pulse" />
          <div className="h-9 w-9 bg-ink-light/10 rounded-lg animate-pulse" />
        </div>

        {/* Day columns skeleton */}
        <div className="flex flex-col gap-3 md:grid md:grid-cols-7 md:gap-2">
          {Array.from({ length: 7 }).map((_, i) => (
            <div
              key={i}
              className="bg-surface rounded-xl border border-ink-light/10 overflow-hidden"
            >
              <div className="bg-cream px-3 py-2">
                <div className="h-4 w-16 bg-ink-light/10 rounded animate-pulse" />
              </div>
              {Array.from({ length: 3 }).map((_, j) => (
                <div key={j} className="px-2 py-2 border-t border-ink-light/5">
                  <div className="h-3 w-8 bg-ink-light/10 rounded animate-pulse mb-1.5" />
                  <div className="h-4 w-full bg-ink-light/10 rounded animate-pulse" />
                </div>
              ))}
            </div>
          ))}
        </div>
      </main>
    </div>
  );
}
