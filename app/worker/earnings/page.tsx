import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Worker App"
      title="Earnings Dashboard"
      description="Daily/weekly/monthly earnings and payout status."
      primaryCta={{ label: "View Jobs", href: "/worker/jobs/history" }}
    />
  );
}
