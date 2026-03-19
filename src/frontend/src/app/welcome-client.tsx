"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import WelcomeScreen from "@/components/welcome-screen";

export default function WelcomeClient() {
  const router = useRouter();
  const [showWelcome, setShowWelcome] = useState<boolean | null>(null);

  useEffect(() => {
    try {
      const seen = localStorage.getItem("plateful-welcome-seen");
      if (seen) {
        router.replace("/login");
        return;
      }
    } catch {
      // localStorage unavailable (incognito, embedded webview) — show welcome
    }
    setShowWelcome(true);
  }, [router]);

  // Loading state while checking localStorage
  if (showWelcome === null) {
    return (
      <div className="min-h-screen bg-cream flex items-center justify-center">
        <span className="text-4xl animate-pulse">🍽️</span>
      </div>
    );
  }

  return <WelcomeScreen />;
}
