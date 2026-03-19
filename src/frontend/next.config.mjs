import withPWA from "next-pwa";

const pwaConfig = withPWA({
  dest: "public",
  register: true,
  skipWaiting: true,
  disable: process.env.NODE_ENV === "development", // Don't cache in dev mode
  fallbacks: {
    document: "/offline", // Show offline page when no network
  },
  runtimeCaching: [
    {
      // Never cache HTML pages — middleware auth must always run
      urlPattern: ({ request }) => request.mode === "navigate",
      handler: "NetworkFirst",
      options: {
        cacheName: "pages",
        networkTimeoutSeconds: 5,
      },
    },
    {
      // Cache static assets normally
      urlPattern: ({ request }) =>
        request.destination === "style" ||
        request.destination === "script" ||
        request.destination === "image" ||
        request.destination === "font",
      handler: "StaleWhileRevalidate",
      options: {
        cacheName: "static-assets",
      },
    },
  ],
});

/** @type {import('next').NextConfig} */
const nextConfig = {
  // Allow recipe images from trusted food blog domains + Supabase storage
  images: {
    remotePatterns: [
      // Supabase storage (your project)
      {
        protocol: "https",
        hostname: "*.supabase.co",
      },
      // OCI Object Storage (future image hosting)
      {
        protocol: "https",
        hostname: "objectstorage.*.oraclecloud.com",
      },
      // Trusted Indian recipe blog CDNs (for global recipe thumbnails)
      { protocol: "https", hostname: "www.indianhealthyrecipes.com" },
      { protocol: "https", hostname: "indianhealthyrecipes.com" },
      { protocol: "https", hostname: "www.vegrecipesofindia.com" },
      { protocol: "https", hostname: "vegrecipesofindia.com" },
      { protocol: "https", hostname: "hebbarskitchen.com" },
      { protocol: "https", hostname: "www.archanaskitchen.com" },
      { protocol: "https", hostname: "www.whiskaffair.com" },
      { protocol: "https", hostname: "myfoodstory.com" },
      { protocol: "https", hostname: "pipingpotcurry.com" },
      { protocol: "https", hostname: "www.cookwithmanali.com" },
      { protocol: "https", hostname: "ministryofcurry.com" },
      // WordPress CDN (serves images for many food blogs)
      { protocol: "https", hostname: "i0.wp.com" },
      { protocol: "https", hostname: "i1.wp.com" },
      { protocol: "https", hostname: "i2.wp.com" },
      { protocol: "https", hostname: "i3.wp.com" },
    ],
  },
};

export default pwaConfig(nextConfig);
