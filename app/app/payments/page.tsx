import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Customer App"
      title="Payments"
      description="Payment methods, transaction history, and invoices."
      primaryCta={{ label: "View Active Request", href: "/app/dashboard" }}
    />
  );
}
