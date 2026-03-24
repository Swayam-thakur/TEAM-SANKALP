import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "QuickSeva Hackathon MVP",
  description:
    "Hyperlocal, real-time worker matching demo for Indian service marketplace use cases."
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
