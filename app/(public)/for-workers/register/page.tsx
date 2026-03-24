import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Worker Acquisition"
      title="Worker Registration"
      description="Low-friction OTP + profile setup onboarding."
      primaryCta={{ label: "Open Worker Dashboard", href: "/worker/dashboard" }}
    />
  );
}
