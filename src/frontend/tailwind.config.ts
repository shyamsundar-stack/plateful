import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        // Plateful food-themed palette
        primary: {
          DEFAULT: "#E07A5F",
          dark: "#C4603F",
          light: "#F0A08A",
        },
        secondary: {
          DEFAULT: "#81B29A",
          dark: "#5E9478",
          light: "#A8D4BE",
        },
        accent: {
          DEFAULT: "#F2CC8F",
          dark: "#E0B56E",
          light: "#F7DEB3",
        },
        cream: "#FEFAE0",
        surface: "#FFFFFF",
        ink: {
          DEFAULT: "#3D405B",
          muted: "#6B7280",
          light: "#9CA3AF",
        },
        draft: "#F59E0B",
        active: "#10B981",
      },
      fontFamily: {
        sans: ["var(--font-nunito)", "system-ui", "sans-serif"],
      },
    },
  },
  plugins: [],
};
export default config;
