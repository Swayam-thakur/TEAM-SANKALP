import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Worker App"
      title="Repeat Customers"
      description="Repeat customer list and quick accept preferences."
      primaryCta={{ label: "Open Dashboard", href: "/worker/dashboard" }}
    />
  );
}
