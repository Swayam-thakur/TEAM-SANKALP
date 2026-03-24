import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Worker App"
      title="Availability Control"
      description="Weekly schedule, instant availability, and work radius controls."
      primaryCta={{ label: "Back to Worker Dashboard", href: "/worker/dashboard" }}
    />
  );
}
