import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Worker App"
      title="Ratings & Reviews"
      description="Customer feedback trends and quality insights."
      primaryCta={{ label: "Improve Profile", href: "/worker/profile" }}
    />
  );
}
