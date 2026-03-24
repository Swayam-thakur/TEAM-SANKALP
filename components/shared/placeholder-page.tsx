import { Footer } from "@/components/shared/footer";
import { Navbar } from "@/components/shared/navbar";
import Link from "next/link";

interface Props {
  section: string;
  title: string;
  description: string;
  primaryCta?: { label: string; href: string };
}

export function PlaceholderPage({ section, title, description, primaryCta }: Props) {
  return (
    <main>
      <Navbar />
      <section className="container-width py-12">
        <p className="text-sm font-semibold text-brand">{section}</p>
        <h1 className="mt-1 text-3xl font-extrabold text-slate-950">{title}</h1>
        <p className="mt-2 max-w-3xl text-slate-600">{description}</p>
        <div className="mt-6 rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
          <p className="font-semibold text-slate-800">Hackathon note</p>
          <p className="mt-1 text-sm text-slate-600">
            This page route is scaffolded and ready for feature expansion.
          </p>
          <div className="mt-4 flex flex-wrap gap-2">
            {primaryCta ? (
              <Link
                href={primaryCta.href}
                className="rounded-lg bg-brand px-4 py-2 text-sm font-bold text-white"
              >
                {primaryCta.label}
              </Link>
            ) : null}
            <Link
              href="/"
              className="rounded-lg border border-slate-300 px-4 py-2 text-sm font-semibold text-slate-700"
            >
              Back to Home
            </Link>
          </div>
        </div>
      </section>
      <Footer />
    </main>
  );
}
