import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Public Website"
      title="Trust & Safety"
      description="Verification framework, dispute handling, and platform safeguards."
      primaryCta={{ label: "Create Request", href: "/app/request/new" }}
    />
  );
}
