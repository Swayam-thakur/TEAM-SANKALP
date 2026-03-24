import { Footer } from "@/components/shared/footer";
import { Navbar } from "@/components/shared/navbar";
import { workers } from "@/lib/data/mock";
import { MapPin, Star } from "lucide-react";
import Link from "next/link";

export default function SearchPage() {
  return (
    <main>
      <Navbar />
      <section className="container-width py-10">
        <h1 className="text-3xl font-extrabold text-slate-950">Worker Search</h1>
        <p className="mt-1 text-slate-600">Filter by availability, distance, rating, and language.</p>

        <div className="mt-6 grid gap-4 md:grid-cols-[280px,1fr]">
          <aside className="rounded-2xl border border-slate-200 bg-white p-4 shadow-sm">
            <p className="font-bold text-slate-900">Filters</p>
            <div className="mt-3 space-y-3 text-sm">
              <label className="flex items-center justify-between">
                <span>Available Now</span>
                <input type="checkbox" defaultChecked />
              </label>
              <label className="block">
                Distance (0.5-20 km)
                <input type="range" min={1} max={20} defaultValue={5} className="mt-2 w-full" />
              </label>
              <label className="block">
                Min Rating
                <select className="mt-1 w-full rounded-lg border border-slate-300 px-2 py-2">
                  <option>4.0+</option>
                  <option>4.5+</option>
                  <option>4.8+</option>
                </select>
              </label>
              <button className="w-full rounded-lg bg-brand px-3 py-2 font-semibold text-white">
                Apply Filters
              </button>
            </div>
          </aside>

          <div className="space-y-3">
            {workers.map((worker) => (
              <div key={worker.id} className="rounded-2xl border border-slate-200 bg-white p-4 shadow-sm">
                <div className="flex flex-wrap items-start justify-between gap-3">
                  <div>
                    <p className="text-lg font-bold text-slate-900">{worker.name}</p>
                    <p className="text-sm text-slate-600">{worker.category}</p>
                    <p className="mt-1 inline-flex items-center gap-1 text-sm text-slate-700">
                      <Star className="h-4 w-4 text-yellow-500" /> {worker.rating} ·{" "}
                      {worker.completedJobs} jobs
                    </p>
                    <p className="mt-1 inline-flex items-center gap-1 text-sm text-slate-700">
                      <MapPin className="h-4 w-4 text-brand" /> {worker.distanceKm} km away · ETA{" "}
                      {worker.etaMins} mins
                    </p>
                  </div>
                  <div className="text-right">
                    <p className="text-sm font-semibold text-slate-700">Rs {worker.ratePerHour}/hr</p>
                    <Link
                      href="/app/request/new"
                      className="mt-2 inline-block rounded-lg bg-brand px-3 py-2 text-sm font-bold text-white"
                    >
                      Request Worker
                    </Link>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>
      <Footer />
    </main>
  );
}
