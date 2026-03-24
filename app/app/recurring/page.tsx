import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Customer App"
      title="Recurring Bookings"
      description="Manage weekly/monthly recurring service plans."
      primaryCta={{ label: "Set New Recurring", href: "/app/request/new" }}
    />
  );
}
