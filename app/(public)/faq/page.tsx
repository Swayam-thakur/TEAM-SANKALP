import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Public Website"
      title="FAQ"
      description="Customer and worker frequently asked questions."
      primaryCta={{ label: "Contact Support", href: "/contact" }}
    />
  );
}
