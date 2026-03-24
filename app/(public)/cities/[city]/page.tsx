import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Public Website"
      title="City Landing Page"
      description="City-specific availability, categories, and trust proof blocks."
      primaryCta={{ label: "Check Nearby Workers", href: "/app/search" }}
    />
  );
}
