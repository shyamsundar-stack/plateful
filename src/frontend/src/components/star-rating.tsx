"use client";

type StarRatingProps = {
  value: number | null;
  onChange?: (rating: number | null) => void;
  size?: "sm" | "md";
  readonly?: boolean;
};

export default function StarRating({
  value,
  onChange,
  size = "md",
  readonly = false,
}: StarRatingProps) {
  const starSize = size === "sm" ? "w-4 h-4" : "w-6 h-6";
  const gap = size === "sm" ? "gap-0.5" : "gap-1";

  function handleClick(star: number) {
    if (readonly || !onChange) return;
    // Click same star again to clear rating
    onChange(value === star ? null : star);
  }

  return (
    <div className={`flex ${gap} items-center`} role="group" aria-label="Star rating">
      {[1, 2, 3, 4, 5].map((star) => {
        const filled = value !== null && star <= value;
        return (
          <button
            key={star}
            type="button"
            onClick={() => handleClick(star)}
            disabled={readonly}
            className={`${readonly ? "cursor-default" : "cursor-pointer hover:scale-110"} transition-transform`}
            aria-label={`${star} star${star > 1 ? "s" : ""}`}
          >
            <svg
              className={`${starSize} ${filled ? "text-accent" : "text-ink-light/30"} transition-colors`}
              viewBox="0 0 24 24"
              fill={filled ? "currentColor" : "none"}
              stroke="currentColor"
              strokeWidth={filled ? 0 : 1.5}
            >
              <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z" />
            </svg>
          </button>
        );
      })}
    </div>
  );
}
