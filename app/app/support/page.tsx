import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Customer App"
      title="Support"
      description="Help center, ticket creation, and dispute support flow."
      primaryCta={{ label: "Track Request", href: "/app/dashboard" }}
    />
  );
}
