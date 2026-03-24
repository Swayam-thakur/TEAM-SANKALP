import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Admin Panel"
      title="Platform Settings"
      description="System-wide configuration for matching and pricing rules."
      primaryCta={{ label: "Back to Admin Dashboard", href: "/admin/dashboard" }}
    />
  );
}
