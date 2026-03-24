import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Worker App"
      title="Worker Support"
      description="FAQs, issue reporting, and escalation support."
      primaryCta={{ label: "Back to Dashboard", href: "/worker/dashboard" }}
    />
  );
}
