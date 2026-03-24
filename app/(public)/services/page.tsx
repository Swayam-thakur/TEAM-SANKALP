import { Footer } from "@/components/shared/footer";
import { Navbar } from "@/components/shared/navbar";
import { serviceCategories } from "@/lib/data/mock";
import Link from "next/link";

export default function ServicesPage() {
  return (
    <main>
      <Navbar />
      <section className="container-width py-12">
        <h1 className="text-4xl font-extrabold text-slate-950">Service Categories</h1>
        <p className="mt-2 text-slate-600">
          All categories are optimized for real-time nearby matching.
        </p>
        <div className="mt-6 grid gap-3 md:grid-cols-3 lg:grid-cols-4">
          {serviceCategories.map((category) => (
            <div key={category} className="rounded-xl border border-slate-200 bg-white p-4 shadow-xs">
              <p className="font-bold text-slate-900">{category}</p>
              <p className="mt-1 text-xs text-slate-500">Avg response: 12-25 mins</p>
              <Link href="/app/request/new" className="mt-2 inline-block text-sm font-bold text-brand">
                Book now
              </Link>
            </div>
          ))}
        </div>
      </section>
      <Footer />
    </main>
  );
}
