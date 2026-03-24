import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Worker Acquisition"
      title="Worker Benefits"
      description="Income, control, and trust growth benefits for workers."
      primaryCta={{ label: "Open Worker Dashboard", href: "/worker/dashboard" }}
    />
  );
}
