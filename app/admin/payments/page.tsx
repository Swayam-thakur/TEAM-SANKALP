import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Admin Panel"
      title="Payments & Reconciliation"
      description="Payment settlement monitoring and payout reconciliation."
      primaryCta={{ label: "Back to Admin Dashboard", href: "/admin/dashboard" }}
    />
  );
}
