import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Worker App"
      title="Profile Management"
      description="Skills, rates, languages, bio, and portfolio settings."
      primaryCta={{ label: "Open Verification", href: "/worker/verification" }}
    />
  );
}
