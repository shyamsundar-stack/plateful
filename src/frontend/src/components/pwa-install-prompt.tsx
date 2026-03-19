"use client";

import { useState, useEffect } from "react";

interface BeforeInstallPromptEvent extends Event {
  prompt(): Promise<void>;
  userChoice: Promise<{ outcome: "accepted" | "dismissed" }>;
}

export default function PWAInstallPrompt() {
  const [deferredPrompt, setDeferredPrompt] =
    useState<BeforeInstallPromptEvent | null>(null);
  const [showBanner, setShowBanner] = useState(false);
  const [isIOS, setIsIOS] = useState(false);
  const [showIOSGuide, setShowIOSGuide] = useState(false);

  useEffect(() => {
    // Check if already installed as PWA
    if (window.matchMedia("(display-mode: standalone)").matches) return;

    // Check if user dismissed the banner before (respect for 7 days)
    const dismissedAt = localStorage.getItem("pwa-banner-dismissed");
    if (dismissedAt) {
      const daysSince =
        (Date.now() - parseInt(dismissedAt)) / (1000 * 60 * 60 * 24);
      if (daysSince < 7) return;
    }

    // Detect iOS (doesn't fire beforeinstallprompt)
    const isApple =
      /iPad|iPhone|iPod/.test(navigator.userAgent) ||
      (navigator.userAgent.includes("Mac") && "ontouchend" in document);
    setIsIOS(isApple);

    // Android/Desktop Chrome fires this event
    const handler = (e: Event) => {
      e.preventDefault();
      setDeferredPrompt(e as BeforeInstallPromptEvent);
      setShowBanner(true);
    };

    window.addEventListener("beforeinstallprompt", handler);

    // On iOS, show banner after a short delay
    if (isApple) {
      const timer = setTimeout(() => setShowBanner(true), 3000);
      return () => {
        clearTimeout(timer);
        window.removeEventListener("beforeinstallprompt", handler);
      };
    }

    return () => window.removeEventListener("beforeinstallprompt", handler);
  }, []);

  const handleInstall = async () => {
    if (deferredPrompt) {
      await deferredPrompt.prompt();
      const { outcome } = await deferredPrompt.userChoice;
      if (outcome === "accepted") {
        setShowBanner(false);
      }
      setDeferredPrompt(null);
    } else if (isIOS) {
      setShowIOSGuide(true);
    }
  };

  const handleDismiss = () => {
    setShowBanner(false);
    setShowIOSGuide(false);
    localStorage.setItem("pwa-banner-dismissed", Date.now().toString());
  };

  if (!showBanner) return null;

  return (
    <>
      {/* Install Banner */}
      <div className="fixed bottom-0 left-0 right-0 z-50 p-4 pb-safe animate-slide-up">
        <div
          className="max-w-md mx-auto bg-white rounded-2xl shadow-2xl border border-primary/20
                      p-4 flex items-center gap-4"
        >
          {/* App Icon */}
          <div className="w-12 h-12 rounded-xl bg-primary flex items-center justify-center flex-shrink-0">
            <span className="text-white text-xl font-bold">P</span>
          </div>

          {/* Text */}
          <div className="flex-1 min-w-0">
            <p className="font-bold text-ink text-sm">Install Plateful</p>
            <p className="text-ink-muted text-xs">
              Add to home screen for the best experience
            </p>
          </div>

          {/* Actions */}
          <div className="flex items-center gap-2 flex-shrink-0">
            <button
              onClick={handleDismiss}
              className="text-ink-muted text-xs hover:text-ink transition-colors px-2 py-1"
            >
              Later
            </button>
            <button
              onClick={handleInstall}
              className="bg-primary text-white text-sm font-semibold px-4 py-2
                         rounded-xl hover:bg-primary-dark active:scale-95 transition-all"
            >
              Install
            </button>
          </div>
        </div>
      </div>

      {/* iOS Instructions Modal */}
      {showIOSGuide && (
        <div className="fixed inset-0 z-[60] bg-black/50 flex items-end justify-center p-4">
          <div className="bg-white rounded-2xl p-6 max-w-sm w-full animate-slide-up">
            <h3 className="text-lg font-bold text-ink mb-4">
              Install Plateful on iPhone
            </h3>

            <div className="space-y-4 mb-6">
              <div className="flex items-start gap-3">
                <div className="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center flex-shrink-0">
                  <span className="text-primary font-bold text-sm">1</span>
                </div>
                <p className="text-ink text-sm pt-1">
                  Tap the{" "}
                  <span className="inline-flex items-center">
                    <svg
                      className="w-5 h-5 text-blue-500 mx-1"
                      fill="none"
                      viewBox="0 0 24 24"
                      strokeWidth={1.5}
                      stroke="currentColor"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        d="M9 8.25H7.5a2.25 2.25 0 0 0-2.25 2.25v9a2.25 2.25 0 0 0 2.25 2.25h9a2.25 2.25 0 0 0 2.25-2.25v-9a2.25 2.25 0 0 0-2.25-2.25H15m0-3-3-3m0 0-3 3m3-3V15"
                      />
                    </svg>
                  </span>
                  <strong>Share</strong> button at the bottom of Safari
                </p>
              </div>

              <div className="flex items-start gap-3">
                <div className="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center flex-shrink-0">
                  <span className="text-primary font-bold text-sm">2</span>
                </div>
                <p className="text-ink text-sm pt-1">
                  Scroll down and tap{" "}
                  <strong>&quot;Add to Home Screen&quot;</strong>
                </p>
              </div>

              <div className="flex items-start gap-3">
                <div className="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center flex-shrink-0">
                  <span className="text-primary font-bold text-sm">3</span>
                </div>
                <p className="text-ink text-sm pt-1">
                  Tap <strong>&quot;Add&quot;</strong> — Plateful will appear on
                  your home screen!
                </p>
              </div>
            </div>

            <button
              onClick={handleDismiss}
              className="w-full bg-primary text-white font-semibold py-3 rounded-xl
                         hover:bg-primary-dark active:scale-95 transition-all"
            >
              Got it!
            </button>
          </div>
        </div>
      )}
    </>
  );
}
