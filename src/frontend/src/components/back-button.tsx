import Link from "next/link";

type BackButtonProps = {
  href: string;
  label?: string;
};

export default function BackButton({
  href,
  label = "Back",
}: BackButtonProps) {
  return (
    <Link
      href={href}
      className="inline-flex items-center gap-1.5 text-sm text-ink-muted hover:text-primary transition-colors mb-4"
    >
      <svg
        className="w-4 h-4"
        fill="none"
        viewBox="0 0 24 24"
        stroke="currentColor"
        strokeWidth={2}
      >
        <polyline points="15 18 9 12 15 6" />
      </svg>
      {label}
    </Link>
  );
}
