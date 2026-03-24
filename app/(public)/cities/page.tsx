import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Public Website"
      title="City Coverage"
      description="Active service zones and launch pipeline by city."
      primaryCta={{ label: "View Services", href: "/services" }}
    />
  );
}
