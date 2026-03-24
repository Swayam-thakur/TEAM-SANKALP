import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Customer App"
      title="Bookings"
      description="Booking history with status filters and quick rebook actions."
      primaryCta={{ label: "Create New Request", href: "/app/request/new" }}
    />
  );
}
