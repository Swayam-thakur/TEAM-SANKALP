import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Customer App"
      title="Booking Details"
      description="Single booking timeline, worker details, and bill breakdown."
      primaryCta={{ label: "Back to Bookings", href: "/app/bookings" }}
    />
  );
}
