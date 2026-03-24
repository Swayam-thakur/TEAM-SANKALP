import { LiveJobsTable } from "@/components/admin/live-jobs-table";
import { Footer } from "@/components/shared/footer";
import { Navbar } from "@/components/shared/navbar";

export default function AdminDashboardPage() {
  return (
    <main>
      <Navbar />
      <section className="container-width py-10">
        <p className="text-sm font-semibold text-brand">Admin Panel</p>
        <h1 className="mt-1 text-3xl font-extrabold text-slate-950">Real-Time Operations Dashboard</h1>
        <p className="mt-2 text-slate-600">
          Monitor job requests, matching performance, and intervention opportunities.
        </p>

        <div className="mt-6 grid gap-4 md:grid-cols-4">
          <StatCard title="Live Requests" value="Auto" note="polling every 4 sec" />
          <StatCard title="Active Workers" value="2,147" note="demo static" />
          <StatCard title="Failed Matches" value="Auto" note="from request states" />
          <StatCard title="Verification Queue" value="84" note="demo static" />
        </div>

        <div className="mt-7">
          <h2 className="text-xl font-extrabold text-slate-900">Live Job Feed</h2>
          <div className="mt-3">
            <LiveJobsTable />
          </div>
        </div>
      </section>
      <Footer />
    </main>
  );
}

function StatCard({ title, value, note }: { title: string; value: string; note: string }) {
  return (
    <div className="rounded-2xl border border-slate-200 bg-white p-4 shadow-sm">
      <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">{title}</p>
      <p className="mt-1 text-2xl font-extrabold text-slate-950">{value}</p>
      <p className="text-xs text-slate-500">{note}</p>
    </div>
  );
}
