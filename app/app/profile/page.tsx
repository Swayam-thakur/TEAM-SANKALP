import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Customer App"
      title="Profile Settings"
      description="Personal details, saved addresses, preferences, and language."
      primaryCta={{ label: "Back to Dashboard", href: "/app/dashboard" }}
    />
  );
}
