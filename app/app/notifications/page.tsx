import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Customer App"
      title="Notifications"
      description="Updates for matching, ETA, completion, and payment events."
      primaryCta={{ label: "Open Dashboard", href: "/app/dashboard" }}
    />
  );
}
