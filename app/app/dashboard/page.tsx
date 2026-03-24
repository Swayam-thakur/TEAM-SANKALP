import { Footer } from "@/components/shared/footer";
import { Navbar } from "@/components/shared/navbar";
import Link from "next/link";

const quickServices = ["Plumbing", "Electrical", "Deep Cleaning", "AC Service"];
const favorites = [
  { name: "Rajan Kumar", skill: "Plumbing", eta: "12 mins" },
  { name: "Meena Devi", skill: "Deep Cleaning", eta: "24 mins" }
];

export default function CustomerDashboardPage() {
  return (
    <main>
      <Navbar />
      <section className="container-width py-10">
        <p className="text-sm font-semibold text-brand">Customer App</p>
        <h1 className="mt-1 text-3xl font-extrabold text-slate-950">Good Morning, Aditi</h1>
        <p className="text-slate-600">HSR Layout, Bengaluru</p>

        <div className="mt-5 rounded-2xl border border-brand/20 bg-brand-light p-4">
          <p className="font-bold text-brand-dark">Need urgent help?</p>
          <p className="text-sm text-slate-700">Post a request and get a nearby worker in minutes.</p>
          <Link
            href="/app/request/new"
            className="mt-3 inline-block rounded-lg bg-brand px-4 py-2 text-sm font-bold text-white"
          >
            Create Instant Request
          </Link>
        </div>

        <div className="mt-6 grid gap-3 md:grid-cols-4">
          {quickServices.map((service) => (
            <Link
              key={service}
              href="/app/request/new"
              className="rounded-xl border border-slate-200 bg-white p-4 text-sm font-bold shadow-xs"
            >
              {service}
            </Link>
          ))}
        </div>

        <div className="mt-8 grid gap-4 md:grid-cols-2">
          <div className="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
            <p className="text-lg font-extrabold text-slate-900">Favorite Workers</p>
            <div className="mt-3 space-y-2">
              {favorites.map((worker) => (
                <div key={worker.name} className="rounded-xl border border-slate-100 p-3">
                  <p className="font-semibold text-slate-900">{worker.name}</p>
                  <p className="text-sm text-slate-600">
                    {worker.skill} · ETA {worker.eta}
                  </p>
                </div>
              ))}
            </div>
          </div>

          <div className="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
            <p className="text-lg font-extrabold text-slate-900">Suggested Nearby</p>
            <p className="mt-1 text-sm text-slate-600">
              Based on your recent plumbing and electrical requests.
            </p>
            <div className="mt-4 flex flex-wrap gap-2">
              <Link
                href="/app/search"
                className="rounded-lg border border-slate-300 px-3 py-2 text-sm font-semibold"
              >
                Open Search
              </Link>
              <Link
                href="/app/request/new"
                className="rounded-lg bg-secondary px-3 py-2 text-sm font-semibold text-white"
              >
                Request Now
              </Link>
            </div>
          </div>
        </div>
      </section>
      <Footer />
    </main>
  );
}
