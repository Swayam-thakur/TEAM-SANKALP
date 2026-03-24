import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./app/**/*.{ts,tsx}",
    "./components/**/*.{ts,tsx}",
    "./lib/**/*.{ts,tsx}"
  ],
  theme: {
    extend: {
      colors: {
        brand: {
          DEFAULT: "#0B6E99",
          dark: "#084C6B",
          light: "#E6F4FA"
        },
        secondary: "#1F8A70",
        energy: "#FF6A00",
        trust: "#0E9F6E",
        warn: "#F59E0B",
        danger: "#D92D20",
        slate: {
          950: "#0F172A",
          700: "#334155",
          500: "#64748B",
          300: "#CBD5E1",
          100: "#E2E8F0",
          50: "#F8FAFC"
        }
      },
      boxShadow: {
        xs: "0 1px 2px rgba(15,23,42,0.06)",
        sm: "0 2px 6px rgba(15,23,42,0.08)",
        md: "0 6px 16px rgba(15,23,42,0.12)",
        lg: "0 10px 24px rgba(15,23,42,0.14)",
        xl: "0 16px 32px rgba(15,23,42,0.18)",
        "2xl": "0 24px 48px rgba(15,23,42,0.22)",
        primary: "0 10px 24px rgba(11,110,153,0.35)"
      },
      fontFamily: {
        sans: ["Manrope", "\"Segoe UI\"", "sans-serif"],
        devanagari: ["\"Noto Sans Devanagari\"", "\"Nirmala UI\"", "sans-serif"]
      }
    }
  },
  plugins: []
};

export default config;
