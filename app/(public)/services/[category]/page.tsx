import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Public Website"
      title="Service Category Detail"
      description="SEO-ready category detail template with scope, pricing range, and CTA."
      primaryCta={{ label: "Book This Service", href: "/app/request/new" }}
    />
  );
}
