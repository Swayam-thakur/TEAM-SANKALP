import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function Page() {
  return (
    <PlaceholderPage
      section="Customer App"
      title="Favorite Workers"
      description="Saved trusted workers for one-tap repeat hiring."
      primaryCta={{ label: "Search Workers", href: "/app/search" }}
    />
  );
}
