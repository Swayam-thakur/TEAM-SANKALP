import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Worker Acquisition"
      title="Worker FAQ"
      description="Common questions on payments, verification, and jobs."
      primaryCta={{ label: "Open Worker Dashboard", href: "/worker/dashboard" }}
    />
  );
}
