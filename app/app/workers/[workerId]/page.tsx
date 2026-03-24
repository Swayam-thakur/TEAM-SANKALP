import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Customer App"
      title="Worker Profile"
      description="Worker hero, rating, skills, rates, and request CTA."
      primaryCta={{ label: "Request This Worker", href: "/app/request/new" }}
    />
  );
}
