import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Worker App"
      title="Active Job"
      description="Current job details, start/complete actions, and issue reporting."
      primaryCta={{ label: "Open Dashboard", href: "/worker/dashboard" }}
    />
  );
}
