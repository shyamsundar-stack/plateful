"use client";

import { useEffect, useRef } from "react";
import { useRouter, usePathname } from "next/navigation";
import { driver, type DriveStep } from "driver.js";
import "driver.js/dist/driver.css";

const STORAGE_KEY = "plateful-tour-completed";

const tourSteps: DriveStep[] = [
  {
    element: '[data-tour="nav-bar"]',
    popover: {
      title: "Welcome to Plateful! 🍽️",
      description:
        "This is your kitchen command center. Use the navigation bar to jump between sections.",
      side: "bottom",
      align: "center",
    },
  },
  {
    element: '[data-tour="nav-recipes"]',
    popover: {
      title: "Your Recipe Library 📖",
      description:
        "Browse, search, and manage all your recipes here. You can add recipes manually, paste from text, or import from a URL.",
      side: "bottom",
      align: "start",
    },
  },
  {
    element: '[data-tour="nav-planner"]',
    popover: {
      title: "Weekly Meal Planner 📅",
      description:
        "Plan your week! Assign recipes to breakfast, lunch, dinner, and snacks for each day.",
      side: "bottom",
      align: "start",
    },
  },
  {
    element: '[data-tour="nav-grocery"]',
    popover: {
      title: "Smart Grocery List 🛒",
      description:
        "Once your week is planned, generate a grocery list. It merges duplicates and groups items by category.",
      side: "bottom",
      align: "start",
    },
  },
  {
    element: '[data-tour="nav-settings"]',
    popover: {
      title: "Settings & Household ⚙️",
      description:
        "Manage your household, family members, and dietary preferences. You can also replay this tour from here anytime!",
      side: "bottom",
      align: "end",
    },
  },
];

// Mobile-specific steps (fewer, since we highlight the drawer)
const mobileTourSteps: DriveStep[] = [
  {
    element: '[data-tour="mobile-menu-toggle"]',
    popover: {
      title: "Welcome to Plateful! 🍽️",
      description:
        "Tap this menu to navigate between sections — Recipes, Planner, Grocery, and more.",
      side: "bottom",
      align: "end",
    },
  },
  {
    element: '[data-tour="mobile-nav-drawer"]',
    popover: {
      title: "Your Navigation Menu 📋",
      description:
        "Here's everything you need: Recipes to manage your library, Planner to organize your week, Grocery to generate shopping lists, and Settings to manage your household.",
      side: "bottom",
      align: "center",
    },
  },
];

export default function FeatureTour() {
  const router = useRouter();
  const pathname = usePathname();
  const driverRef = useRef<ReturnType<typeof driver> | null>(null);
  const hasStarted = useRef(false);

  useEffect(() => {
    // Only run on pages that have the header (not login, not onboarding)
    const isAppPage =
      pathname !== "/login" &&
      pathname !== "/onboarding" &&
      pathname !== "/offline";
    if (!isAppPage) return;

    // Check if tour should run
    const tourCompleted = localStorage.getItem(STORAGE_KEY);
    const urlParams = new URLSearchParams(window.location.search);
    const tourParam = urlParams.get("tour");
    const shouldRun = !tourCompleted || tourParam === "1";

    if (!shouldRun || hasStarted.current) return;
    hasStarted.current = true;

    // Wait for page to fully render
    const timeout = setTimeout(() => {
      const isMobile = window.innerWidth < 768;

      if (isMobile) {
        startMobileTour();
      } else {
        startDesktopTour();
      }
    }, 800);

    return () => {
      clearTimeout(timeout);
      if (driverRef.current) {
        driverRef.current.destroy();
      }
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [pathname]);

  function completeTour() {
    localStorage.setItem(STORAGE_KEY, "true");
    // Clean up ?tour=1 from URL if present
    const url = new URL(window.location.href);
    if (url.searchParams.has("tour")) {
      url.searchParams.delete("tour");
      router.replace(url.pathname + url.search);
    }
  }

  function startDesktopTour() {
    // Verify target elements exist
    const navBar = document.querySelector('[data-tour="nav-bar"]');
    if (!navBar) return;

    driverRef.current = driver({
      showProgress: true,
      animate: true,
      overlayColor: "rgba(61, 64, 91, 0.5)",
      stagePadding: 8,
      stageRadius: 12,
      popoverClass: "plateful-tour-popover",
      nextBtnText: "Next →",
      prevBtnText: "← Back",
      doneBtnText: "Let's Cook! 🍳",
      allowClose: true,
      steps: tourSteps,
      onDestroyStarted: () => {
        completeTour();
        driverRef.current?.destroy();
      },
    });

    driverRef.current.drive();
  }

  function startMobileTour() {
    // First, open the hamburger menu
    const hamburger = document.querySelector(
      '[data-tour="mobile-menu-toggle"]'
    ) as HTMLButtonElement | null;
    if (!hamburger) return;

    // Click hamburger to open drawer
    hamburger.click();

    // Wait for drawer to render, then start tour
    setTimeout(() => {
      driverRef.current = driver({
        showProgress: true,
        animate: true,
        overlayColor: "rgba(61, 64, 91, 0.5)",
        stagePadding: 8,
        stageRadius: 12,
        popoverClass: "plateful-tour-popover",
        nextBtnText: "Next →",
        prevBtnText: "← Back",
        doneBtnText: "Let's Cook! 🍳",
        allowClose: true,
        steps: mobileTourSteps,
        onDestroyStarted: () => {
          completeTour();
          driverRef.current?.destroy();
        },
      });

      driverRef.current.drive();
    }, 300);
  }

  // This component renders nothing — driver.js handles the overlay
  return null;
}
