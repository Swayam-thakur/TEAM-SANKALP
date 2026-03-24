import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Worker App"
      title="Verification Documents"
      description="Aadhaar upload, review status, and verified badge progress."
      primaryCta={{ label: "Upload Documents", href: "/worker/verification" }}
    />
  );
}
