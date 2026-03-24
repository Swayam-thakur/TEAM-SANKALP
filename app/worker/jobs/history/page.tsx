import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Worker App"
      title="Job History"
      description="Completed, cancelled, and pending jobs with filters."
      primaryCta={{ label: "Open Earnings", href: "/worker/earnings" }}
    />
  );
}
