"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";

export default function AuthForm({
  initialMode = "signin",
}: {
  initialMode?: "signin" | "signup";
}) {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [mode, setMode] = useState<"signin" | "signup">(initialMode);
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);
  const [successMessage, setSuccessMessage] = useState<string | null>(null);

  const router = useRouter();
  const supabase = createClient();

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setError(null);
    setSuccessMessage(null);
    setLoading(true);

    try {
      if (mode === "signup") {
        const { error: signUpError } = await supabase.auth.signUp({
          email,
          password,
        });

        if (signUpError) {
          setError(signUpError.message);
          return;
        }

        // Check if email confirmation is required
        // Supabase may auto-confirm in dev mode
        setSuccessMessage(
          "Account created! Check your email to confirm, then sign in."
        );
        setMode("signin");
      } else {
        const { error: signInError } = await supabase.auth.signInWithPassword({
          email,
          password,
        });

        if (signInError) {
          setError(signInError.message);
          return;
        }

        // Success — redirect to recipes
        router.push("/recipes");
        router.refresh();
      }
    } catch {
      setError("Something went wrong. Please try again.");
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="w-full max-w-sm mx-auto">
      {/* Logo */}
      <div className="text-center mb-8">
        <span className="text-5xl" role="img" aria-label="plate">
          🍽️
        </span>
        <h1 className="text-3xl font-bold text-ink mt-3">Plateful</h1>
        <p className="text-ink-muted mt-1">Meal planning made easy</p>
      </div>

      {/* Mode Tabs */}
      <div className="flex mb-6 bg-cream rounded-lg p-1">
        <button
          type="button"
          onClick={() => {
            setMode("signin");
            setError(null);
          }}
          className={`flex-1 py-2 text-sm font-semibold rounded-md transition-all ${
            mode === "signin"
              ? "bg-surface text-ink shadow-sm"
              : "text-ink-muted hover:text-ink"
          }`}
        >
          Sign In
        </button>
        <button
          type="button"
          onClick={() => {
            setMode("signup");
            setError(null);
          }}
          className={`flex-1 py-2 text-sm font-semibold rounded-md transition-all ${
            mode === "signup"
              ? "bg-surface text-ink shadow-sm"
              : "text-ink-muted hover:text-ink"
          }`}
        >
          Sign Up
        </button>
      </div>

      {/* Success Message */}
      {successMessage && (
        <div className="mb-4 p-3 rounded-lg bg-secondary/10 text-secondary-dark text-sm">
          {successMessage}
        </div>
      )}

      {/* Error Message */}
      {error && (
        <div className="mb-4 p-3 rounded-lg bg-red-50 text-red-600 text-sm">
          {error}
        </div>
      )}

      {/* Form */}
      <form onSubmit={handleSubmit} className="space-y-4">
        <div>
          <label
            htmlFor="email"
            className="block text-sm font-medium text-ink mb-1"
          >
            Email
          </label>
          <input
            id="email"
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
            placeholder="you@example.com"
            className="w-full px-3 py-2.5 rounded-lg border border-ink-light/30 bg-surface text-ink placeholder:text-ink-light focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary transition-all"
          />
        </div>

        <div>
          <label
            htmlFor="password"
            className="block text-sm font-medium text-ink mb-1"
          >
            Password
          </label>
          <input
            id="password"
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            minLength={6}
            placeholder="At least 6 characters"
            className="w-full px-3 py-2.5 rounded-lg border border-ink-light/30 bg-surface text-ink placeholder:text-ink-light focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary transition-all"
          />
        </div>

        <button
          type="submit"
          disabled={loading}
          className="w-full py-2.5 rounded-lg bg-primary text-white font-semibold hover:bg-primary-dark transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {loading
            ? "Please wait..."
            : mode === "signin"
            ? "Sign In"
            : "Create Account"}
        </button>
      </form>
    </div>
  );
}
