import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Auth"
      title="Signup"
      description="Dual signup flow with OTP-based onboarding."
      primaryCta={{ label: "Join as Worker", href: "/for-workers" }}
    />
  );
}
