import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Worker App"
      title="Job Detail"
      description="Detailed view for a single worker job record."
      primaryCta={{ label: "Back to Job History", href: "/worker/jobs/history" }}
    />
  );
}
