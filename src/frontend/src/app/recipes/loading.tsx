export default function RecipesLoading() {
  return (
    <div className="min-h-screen bg-cream">
      {/* Header skeleton */}
      <div className="sticky top-0 z-50 bg-surface border-b border-accent/30">
        <div className="max-w-5xl mx-auto px-4 py-3 flex items-center justify-between">
          <div className="flex items-center gap-2">
            <div className="w-8 h-8 rounded-full bg-ink-light/10 animate-pulse" />
            <div className="w-20 h-6 rounded bg-ink-light/10 animate-pulse" />
          </div>
          <div className="w-16 h-8 rounded-lg bg-ink-light/10 animate-pulse" />
        </div>
      </div>

      <main className="max-w-5xl mx-auto px-4 py-6">
        {/* Title skeleton */}
        <div className="w-36 h-8 rounded bg-ink-light/10 animate-pulse mb-6" />

        {/* Search bar skeleton */}
        <div className="w-full h-10 rounded-lg bg-ink-light/10 animate-pulse mb-3" />

        {/* Filter chips skeleton */}
        <div className="flex gap-2 mb-6">
          {[1, 2, 3, 4, 5].map((i) => (
            <div
              key={i}
              className="w-16 h-7 rounded-full bg-ink-light/10 animate-pulse"
            />
          ))}
        </div>

        {/* Card grid skeleton */}
        <div className="grid grid-cols-2 gap-3 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4">
          {[1, 2, 3, 4, 5, 6].map((i) => (
            <div
              key={i}
              className="bg-surface rounded-xl overflow-hidden shadow-sm border border-ink-light/10"
            >
              <div className="aspect-[4/3] bg-ink-light/10 animate-pulse" />
              <div className="p-3 space-y-2">
                <div className="w-3/4 h-4 rounded bg-ink-light/10 animate-pulse" />
                <div className="w-1/2 h-3 rounded bg-ink-light/10 animate-pulse" />
                <div className="flex gap-1">
                  <div className="w-12 h-4 rounded bg-ink-light/10 animate-pulse" />
                  <div className="w-12 h-4 rounded bg-ink-light/10 animate-pulse" />
                </div>
              </div>
            </div>
          ))}
        </div>
      </main>
    </div>
  );
}
