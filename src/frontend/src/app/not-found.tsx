import Link from "next/link";

export default function NotFound() {
  return (
    <div className="min-h-screen bg-cream flex items-center justify-center">
      <div className="text-center px-4">
        <p className="text-6xl mb-4">🍽️</p>
        <h1 className="text-2xl font-bold text-ink mb-2">Page not found</h1>
        <p className="text-sm text-ink-muted mb-6 max-w-md">
          The page you&apos;re looking for doesn&apos;t exist or has been moved.
        </p>
        <Link
          href="/recipes"
          className="inline-block px-6 py-2.5 rounded-lg bg-primary text-white text-sm font-semibold hover:bg-primary-dark transition-colors"
        >
          Go to Recipes
        </Link>
      </div>
    </div>
  );
}
