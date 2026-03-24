import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Admin Panel"
      title="Category Management"
      description="Service category CRUD and city mapping controls."
      primaryCta={{ label: "Back to Admin Dashboard", href: "/admin/dashboard" }}
    />
  );
}
