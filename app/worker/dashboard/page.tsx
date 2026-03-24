import { IncomingJobs } from "@/components/worker/incoming-jobs";
import { Footer } from "@/components/shared/footer";
import { Navbar } from "@/components/shared/navbar";

export default function WorkerDashboardPage() {
  return (
    <main>
      <Navbar />
      <section className="container-width py-10">
        <p className="text-sm font-semibold text-secondary">Worker App</p>
        <h1 className="mt-1 text-3xl font-extrabold text-slate-950">Worker Dashboard</h1>

        <div className="mt-5 grid gap-4 md:grid-cols-3">
          <Metric title="Today's Jobs" value="3" />
          <Metric title="Today's Earnings" value="Rs 2,150" />
          <Metric title="Rating" value="4.8" />
        </div>

        <div className="mt-6 rounded-2xl border border-secondary/20 bg-green-50 p-4">
          <p className="font-bold text-secondary">Availability: ON</p>
          <p className="text-sm text-slate-700">
            You are visible for nearby requests in a 5 km radius.
          </p>
        </div>

        <div className="mt-6">
          <h2 className="text-xl font-extrabold text-slate-900">Incoming Job Alerts</h2>
          <p className="text-sm text-slate-600">
            Full-screen mobile alert style with countdown and quick decisions.
          </p>
          <div className="mt-3">
            <IncomingJobs />
          </div>
        </div>
      </section>
      <Footer />
    </main>
  );
}

function Metric({ title, value }: { title: string; value: string }) {
  return (
    <div className="rounded-2xl border border-slate-200 bg-white p-4 shadow-sm">
      <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">{title}</p>
      <p className="mt-1 text-2xl font-extrabold text-slate-950">{value}</p>
    </div>
  );
}
