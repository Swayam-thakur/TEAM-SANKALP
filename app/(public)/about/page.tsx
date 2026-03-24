import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Public Website"
      title="About QuickSeva"
      description="Mission, values, and founding narrative for trust-first hyperlocal services."
      primaryCta={{ label: "Open Customer App", href: "/app/dashboard" }}
    />
  );
}
