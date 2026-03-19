"use client";

import { useState } from "react";
import { useRouter, usePathname } from "next/navigation";
import Link from "next/link";
import { createClient } from "@/lib/supabase/client";

const navLinks = [
  { href: "/recipes", label: "Recipes", tourId: "nav-recipes" },
  { href: "/planner", label: "Planner", tourId: "nav-planner" },
  { href: "/nutrition", label: "Nutrition", tourId: undefined },
  { href: "/grocery", label: "Grocery", tourId: "nav-grocery" },
  { href: "/prep", label: "Prep", tourId: undefined },
  { href: "/analytics", label: "Analytics", tourId: undefined },
  { href: "/settings", label: "Settings", tourId: "nav-settings" },
];

export default function Header() {
  const router = useRouter();
  const pathname = usePathname();
  const supabase = createClient();
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);

  async function handleSignOut() {
    try {
      await supabase.auth.signOut();
      router.push("/login");
      router.refresh();
    } catch {
      router.push("/login");
    }
  }

  return (
    <header className="sticky top-0 z-50 bg-surface border-b border-ink-light/15 shadow-sm">
      <div className="max-w-5xl mx-auto px-4 py-3 flex items-center justify-between">
        {/* Logo */}
        <Link href="/recipes" className="flex items-center gap-2 shrink-0">
          <span className="text-2xl" role="img" aria-label="Plateful logo">
            🍽️
          </span>
          <h1 className="text-xl font-bold text-ink">Plateful</h1>
        </Link>

        {/* Desktop Nav */}
        <nav className="hidden md:flex items-center gap-1" aria-label="Main navigation" data-tour="nav-bar">
          {navLinks.map((link) => {
            const isActive = pathname.startsWith(link.href);
            return (
              <Link
                key={link.href}
                href={link.href}
                {...(link.tourId ? { "data-tour": link.tourId } : {})}
                className={`px-3 py-1.5 rounded-lg text-sm font-medium transition-colors ${
                  isActive
                    ? "text-primary bg-primary/10"
                    : "text-ink-muted hover:text-ink hover:bg-cream"
                }`}
              >
                {link.label}
              </Link>
            );
          })}
        </nav>

        {/* Desktop Sign Out */}
        <button
          onClick={handleSignOut}
          className="hidden md:block text-sm text-ink-muted hover:text-primary transition-colors px-3 py-1.5 rounded-lg hover:bg-cream"
        >
          Sign Out
        </button>

        {/* Mobile: hamburger */}
        <button
          onClick={() => setMobileMenuOpen((prev) => !prev)}
          className="md:hidden p-2 rounded-lg text-ink-muted hover:text-ink hover:bg-cream transition-colors"
          aria-label={mobileMenuOpen ? "Close menu" : "Open menu"}
          aria-expanded={mobileMenuOpen}
          data-tour="mobile-menu-toggle"
        >
          {mobileMenuOpen ? (
            /* X icon */
            <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
              <line x1="18" y1="6" x2="6" y2="18" />
              <line x1="6" y1="6" x2="18" y2="18" />
            </svg>
          ) : (
            /* Hamburger icon */
            <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
              <line x1="4" y1="6" x2="20" y2="6" />
              <line x1="4" y1="12" x2="20" y2="12" />
              <line x1="4" y1="18" x2="20" y2="18" />
            </svg>
          )}
        </button>
      </div>

      {/* Mobile Menu Drawer */}
      {mobileMenuOpen && (
        <div className="md:hidden border-t border-ink-light/15 bg-surface" data-tour="mobile-nav-drawer">
          <nav className="max-w-5xl mx-auto px-4 py-2 flex flex-col gap-1" aria-label="Mobile navigation">
            {navLinks.map((link) => {
              const isActive = pathname.startsWith(link.href);
              return (
                <Link
                  key={link.href}
                  href={link.href}
                  onClick={() => setMobileMenuOpen(false)}
                  className={`px-3 py-2.5 rounded-lg text-sm font-medium transition-colors ${
                    isActive
                      ? "text-primary bg-primary/10"
                      : "text-ink-muted hover:text-ink hover:bg-cream"
                  }`}
                >
                  {link.label}
                </Link>
              );
            })}
            <div className="border-t border-ink-light/10 mt-1 pt-1">
              <button
                onClick={handleSignOut}
                className="w-full text-left px-3 py-2.5 text-sm text-ink-muted hover:text-primary transition-colors rounded-lg hover:bg-cream"
              >
                Sign Out
              </button>
            </div>
          </nav>
        </div>
      )}
    </header>
  );
}
