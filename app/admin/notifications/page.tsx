import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Admin Panel"
      title="Notification Console"
      description="Push/SMS campaign sender and template control."
      primaryCta={{ label: "Back to Admin Dashboard", href: "/admin/dashboard" }}
    />
  );
}
