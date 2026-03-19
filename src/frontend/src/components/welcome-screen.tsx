"use client";

import { useState, useCallback, useRef, useEffect } from "react";
import { useRouter } from "next/navigation";

const STORAGE_KEY = "plateful-welcome-seen";

const slides = [
  {
    emoji: "🍽️",
    headline: "Plan meals your family actually wants to eat",
    subtext:
      "Plateful helps Indian households plan balanced weekly meals — with recipes everyone loves, dietary preferences respected, and zero guesswork.",
    bgClass: "from-primary/8 via-cream to-cream",
    decorativeEmoji: ["🍛", "🥘", "🍚", "🫓"],
  },
  {
    emoji: "🛒",
    headline: "One tap to your grocery list",
    subtext:
      "Plan your week, and Plateful auto-generates a smart shopping list — grouped by category, duplicates merged, quantities calculated.",
    bgClass: "from-secondary/8 via-cream to-cream",
    decorativeEmoji: ["🥕", "🧅", "🍅", "🫑"],
  },
  {
    emoji: "⏰",
    headline: "Weekend prep, weekday freedom",
    subtext:
      "Plateful tells you what to prep on Sunday so weeknight dinners take minutes, not hours. Batch cook smart, eat well all week.",
    bgClass: "from-accent/10 via-cream to-cream",
    decorativeEmoji: ["🔪", "🥣", "🍲", "✨"],
  },
];

export default function WelcomeScreen() {
  const router = useRouter();
  const [currentSlide, setCurrentSlide] = useState(0);
  const [dragOffset, setDragOffset] = useState(0);
  const [isDragging, setIsDragging] = useState(false);
  const touchStartX = useRef(0);
  const containerRef = useRef<HTMLDivElement>(null);

  const goToSlide = useCallback((index: number) => {
    if (index >= 0 && index < slides.length) {
      setCurrentSlide(index);
    }
  }, []);

  function markSeenAndNavigate(mode: "signup" | "signin") {
    try {
      localStorage.setItem(STORAGE_KEY, "true");
    } catch {
      // localStorage unavailable — continue anyway
    }
    router.push(`/login?mode=${mode}`);
  }

  // --- Touch swipe with finger-follow ---
  function handleTouchStart(e: React.TouchEvent) {
    touchStartX.current = e.touches[0].clientX;
    setIsDragging(true);
    setDragOffset(0);
  }

  function handleTouchMove(e: React.TouchEvent) {
    const currentX = e.touches[0].clientX;
    const diff = currentX - touchStartX.current;
    // Clamp drag at edges
    if (currentSlide === 0 && diff > 0) {
      setDragOffset(diff * 0.3); // rubber-band effect
    } else if (currentSlide === slides.length - 1 && diff < 0) {
      setDragOffset(diff * 0.3);
    } else {
      setDragOffset(diff);
    }
  }

  function handleTouchEnd() {
    setIsDragging(false);
    const threshold = 50;
    if (dragOffset < -threshold && currentSlide < slides.length - 1) {
      goToSlide(currentSlide + 1);
    } else if (dragOffset > threshold && currentSlide > 0) {
      goToSlide(currentSlide - 1);
    }
    setDragOffset(0);
  }

  // --- Keyboard navigation ---
  useEffect(() => {
    function handleKeyDown(e: KeyboardEvent) {
      if (e.key === "ArrowRight" || e.key === "ArrowDown") {
        e.preventDefault();
        setCurrentSlide((prev) => Math.min(prev + 1, slides.length - 1));
      } else if (e.key === "ArrowLeft" || e.key === "ArrowUp") {
        e.preventDefault();
        setCurrentSlide((prev) => Math.max(prev - 1, 0));
      } else if (e.key === "Enter") {
        if (currentSlide === slides.length - 1) {
          markSeenAndNavigate("signup");
        }
      }
    }
    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [currentSlide]);

  const isLastSlide = currentSlide === slides.length - 1;

  return (
    <div className="fixed inset-0 bg-cream z-50 flex flex-col overflow-hidden">
      {/* Background gradient that shifts per slide */}
      <div
        className={`absolute inset-0 bg-gradient-to-b ${slides[currentSlide].bgClass} transition-all duration-700 ease-out`}
      />

      {/* Floating decorative emoji — subtle background personality */}
      <div className="absolute inset-0 overflow-hidden pointer-events-none" aria-hidden="true">
        {slides[currentSlide].decorativeEmoji.map((emoji, i) => (
          <span
            key={`${currentSlide}-${i}`}
            className="absolute text-2xl opacity-[0.07] transition-opacity duration-700"
            style={{
              top: `${15 + i * 22}%`,
              left: i % 2 === 0 ? `${5 + i * 3}%` : undefined,
              right: i % 2 === 1 ? `${5 + i * 3}%` : undefined,
            }}
          >
            {emoji}
          </span>
        ))}
      </div>

      {/* Content wrapper — relative to stack above background */}
      <div className="relative z-10 flex flex-col h-full">
        {/* Top bar: wordmark + skip */}
        <div className="flex items-center justify-between px-5 pt-3 pb-1 md:pt-5 md:pb-2">
          <span className="text-sm font-bold text-primary-dark tracking-wide uppercase">
            Plateful
          </span>
          <button
            onClick={() => markSeenAndNavigate("signin")}
            className="text-sm text-ink-muted hover:text-ink transition-colors px-3 py-2.5 min-h-[44px] rounded-lg hover:bg-surface/50"
          >
            Skip
          </button>
        </div>

        {/* Slides area — mobile: single column centered, desktop: split layout */}
        <div
          ref={containerRef}
          className="flex-1 flex items-center justify-center px-5 md:px-12 lg:px-20"
          onTouchStart={handleTouchStart}
          onTouchMove={handleTouchMove}
          onTouchEnd={handleTouchEnd}
        >
          <div className="w-full max-w-4xl">
            {/* Desktop: split layout | Mobile: centered single column */}
            <div className="flex flex-col md:flex-row md:items-center md:gap-12 lg:gap-20">
              {/* Left side (desktop) / Top (mobile): visual */}
              <div className="flex-shrink-0 flex items-center justify-center md:w-2/5">
                <div className="relative">
                  {/* Gradient circle behind emoji */}
                  <div
                    className={`w-20 h-20 md:w-40 md:h-40 rounded-full bg-gradient-to-br ${slides[currentSlide].bgClass} flex items-center justify-center transition-all duration-500`}
                  >
                    <span
                      className="text-4xl md:text-8xl transition-transform duration-500"
                      style={{
                        transform: isDragging
                          ? `translateX(${dragOffset * 0.15}px)`
                          : undefined,
                      }}
                      role="img"
                    >
                      {slides[currentSlide].emoji}
                    </span>
                  </div>
                </div>
              </div>

              {/* Right side (desktop) / Bottom (mobile): text */}
              <div
                className="md:w-3/5 text-center md:text-left mt-4 md:mt-0 overflow-hidden"
              >
                <div
                  className="transition-transform duration-500 ease-out"
                  style={{
                    transform: isDragging
                      ? `translateX(${dragOffset * 0.5}px)`
                      : undefined,
                  }}
                >
                  <h1 className="text-xl md:text-3xl font-bold text-ink leading-tight mb-2 md:mb-4">
                    {slides[currentSlide].headline}
                  </h1>
                  <p className="text-sm md:text-base text-ink-muted leading-relaxed max-w-sm mx-auto md:mx-0">
                    {slides[currentSlide].subtext}
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Bottom section: arrows + dots + buttons */}
        <div className="px-5 pb-6 pt-2 md:pb-8 md:pt-4 space-y-3 md:space-y-5">
          {/* Navigation row: arrows + dots */}
          <div className="flex items-center justify-center gap-4">
            {/* Left arrow — visible on md+ */}
            <button
              onClick={() => goToSlide(currentSlide - 1)}
              disabled={currentSlide === 0}
              className="hidden md:flex items-center justify-center w-11 h-11 rounded-full border border-ink-light/20 text-ink-muted hover:text-ink hover:border-ink-light/40 transition-all disabled:opacity-30 disabled:cursor-not-allowed"
              aria-label="Previous slide"
            >
              <svg width="18" height="18" viewBox="0 0 18 18" fill="none" className="rotate-180">
                <path d="M6.75 3.75L12 9L6.75 14.25" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
              </svg>
            </button>

            {/* Dot indicators with 44px touch targets */}
            <div className="flex items-center justify-center gap-1" role="tablist">
              {slides.map((_, i) => (
                <button
                  key={i}
                  onClick={() => goToSlide(i)}
                  className="flex items-center justify-center min-w-[44px] min-h-[44px]"
                  role="tab"
                  aria-selected={i === currentSlide}
                  aria-label={`Go to slide ${i + 1}`}
                >
                  <span
                    className={`rounded-full transition-all duration-300 ${
                      i === currentSlide
                        ? "bg-primary w-8 h-2.5"
                        : "bg-ink-light/20 w-2.5 h-2.5 hover:bg-ink-light/40"
                    }`}
                  />
                </button>
              ))}
            </div>

            {/* Right arrow — visible on md+ */}
            <button
              onClick={() => goToSlide(currentSlide + 1)}
              disabled={currentSlide === slides.length - 1}
              className="hidden md:flex items-center justify-center w-11 h-11 rounded-full border border-ink-light/20 text-ink-muted hover:text-ink hover:border-ink-light/40 transition-all disabled:opacity-30 disabled:cursor-not-allowed"
              aria-label="Next slide"
            >
              <svg width="18" height="18" viewBox="0 0 18 18" fill="none">
                <path d="M6.75 3.75L12 9L6.75 14.25" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
              </svg>
            </button>
          </div>

          {/* Action buttons */}
          <div className="max-w-md mx-auto w-full space-y-3">
            {isLastSlide ? (
              <>
                <button
                  onClick={() => markSeenAndNavigate("signup")}
                  className="w-full py-3.5 rounded-xl bg-primary text-white font-bold text-lg
                    hover:bg-primary-dark active:scale-[0.98] transition-all shadow-md shadow-primary/20
                    min-h-[48px]"
                >
                  Get Started
                </button>
                <button
                  onClick={() => markSeenAndNavigate("signin")}
                  className="w-full py-2.5 text-sm text-ink-muted hover:text-ink transition-colors
                    min-h-[44px]"
                >
                  I already have an account
                </button>
              </>
            ) : (
              <button
                onClick={() => goToSlide(currentSlide + 1)}
                className="w-full py-3.5 rounded-xl bg-primary text-white font-bold text-lg
                  hover:bg-primary-dark active:scale-[0.98] transition-all shadow-md shadow-primary/20
                  min-h-[48px]"
              >
                Next
              </button>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
