import type { Metadata, Viewport } from "next";
import { Nunito } from "next/font/google";
import PWAInstallPrompt from "@/components/pwa-install-prompt";
import FeatureTour from "@/components/feature-tour";
import "./globals.css";

const nunito = Nunito({
  subsets: ["latin"],
  variable: "--font-nunito",
  display: "swap",
});

export const viewport: Viewport = {
  width: "device-width",
  initialScale: 1,
  maximumScale: 1,
  userScalable: false,
  themeColor: "#E07A5F",
};

export const metadata: Metadata = {
  title: "Plateful — Meal Planning Made Easy",
  description:
    "Plan balanced weekly meals, optimize batch prep, and auto-generate grocery lists.",
  manifest: "/manifest.json",
  appleWebApp: {
    capable: true,
    statusBarStyle: "default",
    title: "Plateful",
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <head>
        <link rel="apple-touch-icon" href="/icon-192.png" />
      </head>
      <body className={`${nunito.variable} font-sans antialiased`}>
        {children}
        <PWAInstallPrompt />
        <FeatureTour />
      </body>
    </html>
  );
}
