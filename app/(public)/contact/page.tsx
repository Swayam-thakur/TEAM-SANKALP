import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Public Website"
      title="Contact Support"
      description="Ticket submission, callback support, and escalation channels."
      primaryCta={{ label: "Go to Support", href: "/app/support" }}
    />
  );
}
