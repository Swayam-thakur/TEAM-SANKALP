import { RequestForm } from "@/components/customer/request-form";
import { Footer } from "@/components/shared/footer";
import { Navbar } from "@/components/shared/navbar";
import { cityStats, serviceCategories } from "@/lib/data/mock";
import Link from "next/link";
import { ArrowRight, ShieldCheck, Timer, UserRoundCheck } from "lucide-react";

export default function HomePage() {
  return (
    <main>
      <Navbar />

      <section className="bg-grid border-b border-slate-100 py-14">
        <div className="container-width grid gap-8 md:grid-cols-2 md:items-center">
          <div>
            <p className="inline-flex rounded-full bg-brand-light px-3 py-1 text-xs font-bold text-brand-dark">
              Hyperlocal Real-Time Service Matching
            </p>
            <h1 className="mt-3 text-4xl font-extrabold leading-tight text-slate-950 md:text-5xl">
              Book a verified nearby worker in minutes.
            </h1>
            <p className="mt-3 text-base text-slate-600 md:text-lg">
              QuickSeva connects customers and blue-collar professionals directly. No middleman. No
              waiting for callbacks.
            </p>

            <div className="mt-5 grid gap-2 text-sm text-slate-700">
              <p className="inline-flex items-center gap-2">
                <Timer className="h-4 w-4 text-energy" /> Same-hour matching with expanding search
                waves
              </p>
              <p className="inline-flex items-center gap-2">
                <ShieldCheck className="h-4 w-4 text-trust" /> Progressive trust verification and
                rating system
              </p>
              <p className="inline-flex items-center gap-2">
                <UserRoundCheck className="h-4 w-4 text-secondary" /> Repeat hiring with favorite
                workers
              </p>
            </div>
          </div>

          <RequestForm compact />
        </div>
      </section>

      <section className="container-width py-12">
        <div className="grid gap-4 rounded-2xl border border-slate-200 bg-white p-5 md:grid-cols-4">
          <Stat title="Workers Registered" value="42,000+" />
          <Stat title="Jobs Completed" value="1,80,000+" />
          <Stat title="Cities Active" value="31" />
          <Stat title="Repeat Hire Rate" value="63%" />
        </div>
      </section>

      <section className="container-width py-6">
        <div className="flex items-center justify-between">
          <h2 className="text-2xl font-extrabold text-slate-950">Popular Services</h2>
          <Link href="/services" className="inline-flex items-center gap-1 text-sm font-bold text-brand">
            View all <ArrowRight className="h-4 w-4" />
          </Link>
        </div>
        <div className="mt-4 grid gap-3 md:grid-cols-3 lg:grid-cols-6">
          {serviceCategories.slice(0, 12).map((category) => (
            <div
              key={category}
              className="rounded-xl border border-slate-200 bg-white p-3 text-sm font-semibold text-slate-700 shadow-xs transition hover:-translate-y-0.5 hover:shadow-sm"
            >
              {category}
            </div>
          ))}
        </div>
      </section>

      <section className="container-width py-12">
        <h2 className="text-2xl font-extrabold text-slate-950">City Coverage Snapshot</h2>
        <div className="mt-4 overflow-x-auto rounded-2xl border border-slate-200 bg-white">
          <table className="min-w-full text-left text-sm">
            <thead className="bg-slate-50 text-slate-600">
              <tr>
                <th className="px-4 py-3">City</th>
                <th className="px-4 py-3">Workers</th>
                <th className="px-4 py-3">Completed Jobs</th>
              </tr>
            </thead>
            <tbody>
              {cityStats.map((row) => (
                <tr key={row.city} className="border-t border-slate-100">
                  <td className="px-4 py-3 font-semibold text-slate-800">{row.city}</td>
                  <td className="px-4 py-3">{row.workers.toLocaleString("en-IN")}</td>
                  <td className="px-4 py-3">{row.jobs.toLocaleString("en-IN")}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </section>

      <section className="container-width py-8">
        <div className="grid gap-3 rounded-2xl bg-brand-dark p-6 md:grid-cols-2 md:items-center">
          <div>
            <h3 className="text-2xl font-extrabold text-white">Need help now or want work today?</h3>
            <p className="mt-2 text-sm text-slate-200">
              Use customer and worker app demos below to showcase end-to-end flow.
            </p>
          </div>
          <div className="flex flex-wrap gap-2 md:justify-end">
            <Link
              href="/app/dashboard"
              className="rounded-xl bg-white px-4 py-2 text-sm font-bold text-brand-dark"
            >
              Open Customer Demo
            </Link>
            <Link
              href="/worker/dashboard"
              className="rounded-xl bg-energy px-4 py-2 text-sm font-bold text-white"
            >
              Open Worker Demo
            </Link>
            <Link
              href="/admin/dashboard"
              className="rounded-xl border border-slate-400 px-4 py-2 text-sm font-bold text-white"
            >
              Open Admin Demo
            </Link>
          </div>
        </div>
      </section>

      <Footer />
    </main>
  );
}

function Stat({ title, value }: { title: string; value: string }) {
  return (
    <div className="rounded-xl border border-slate-100 p-3">
      <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">{title}</p>
      <p className="mt-1 text-2xl font-extrabold text-slate-950">{value}</p>
    </div>
  );
}
