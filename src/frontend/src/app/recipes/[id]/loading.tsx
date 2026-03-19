export default function RecipeDetailLoading() {
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

      <main className="max-w-3xl mx-auto px-4 py-6">
        {/* Back button skeleton */}
        <div className="w-32 h-5 rounded bg-ink-light/10 animate-pulse mb-4" />

        {/* Status badge */}
        <div className="w-16 h-6 rounded-full bg-ink-light/10 animate-pulse mb-2" />

        {/* Title */}
        <div className="w-2/3 h-8 rounded bg-ink-light/10 animate-pulse mb-2" />

        {/* Description */}
        <div className="w-full h-4 rounded bg-ink-light/10 animate-pulse mb-1" />
        <div className="w-3/4 h-4 rounded bg-ink-light/10 animate-pulse mb-6" />

        {/* Meta chips */}
        <div className="flex gap-2 mb-6">
          <div className="w-16 h-7 rounded-lg bg-ink-light/10 animate-pulse" />
          <div className="w-20 h-7 rounded-lg bg-ink-light/10 animate-pulse" />
          <div className="w-16 h-7 rounded-lg bg-ink-light/10 animate-pulse" />
        </div>

        {/* Times */}
        <div className="flex gap-4 mb-6">
          <div className="w-20 h-4 rounded bg-ink-light/10 animate-pulse" />
          <div className="w-20 h-4 rounded bg-ink-light/10 animate-pulse" />
          <div className="w-24 h-4 rounded bg-ink-light/10 animate-pulse" />
        </div>

        {/* Ingredients section */}
        <div className="w-32 h-6 rounded bg-ink-light/10 animate-pulse mb-3" />
        {[1, 2, 3, 4, 5].map((i) => (
          <div key={i} className="w-full h-4 rounded bg-ink-light/10 animate-pulse mb-2" />
        ))}

        {/* Steps section */}
        <div className="w-20 h-6 rounded bg-ink-light/10 animate-pulse mt-6 mb-3" />
        {[1, 2, 3].map((i) => (
          <div key={i} className="flex gap-3 mb-4">
            <div className="w-7 h-7 rounded-full bg-ink-light/10 animate-pulse flex-shrink-0" />
            <div className="flex-1">
              <div className="w-full h-4 rounded bg-ink-light/10 animate-pulse mb-1" />
              <div className="w-2/3 h-4 rounded bg-ink-light/10 animate-pulse" />
            </div>
          </div>
        ))}
      </main>
    </div>
  );
}
