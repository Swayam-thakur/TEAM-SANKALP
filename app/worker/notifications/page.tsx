import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Worker App"
      title="Notifications"
      description="Incoming alerts, payout notices, and review prompts."
      primaryCta={{ label: "Back to Dashboard", href: "/worker/dashboard" }}
    />
  );
}
