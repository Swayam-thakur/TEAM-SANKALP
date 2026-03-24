import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Worker Acquisition"
      title="Income Calculator"
      description="Estimate weekly and monthly earnings by availability."
      primaryCta={{ label: "Open Worker Dashboard", href: "/worker/dashboard" }}
    />
  );
}
