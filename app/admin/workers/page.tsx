import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Admin Panel"
      title="Worker Management"
      description="Worker profiles, availability, and quality controls."
      primaryCta={{ label: "Back to Admin Dashboard", href: "/admin/dashboard" }}
    />
  );
}
