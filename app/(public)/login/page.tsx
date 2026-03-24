import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Auth"
      title="Login"
      description="Dual login entry for customers and workers."
      primaryCta={{ label: "Open Customer Dashboard", href: "/app/dashboard" }}
    />
  );
}
