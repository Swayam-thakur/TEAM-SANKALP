import { Footer } from "@/components/shared/footer";
import { Navbar } from "@/components/shared/navbar";
import Link from "next/link";

export default function ForWorkersPage() {
  return (
    <main>
      <Navbar />
      <section className="container-width py-12">
        <h1 className="text-4xl font-extrabold text-slate-950">For Workers</h1>
        <p className="mt-2 max-w-3xl text-slate-600">
          QuickSeva is a digital naka replacement. Get nearby jobs, direct payments, and repeat
          customers without middlemen cuts.
        </p>
        <div className="mt-8 grid gap-4 md:grid-cols-3">
          <Card title="No Middleman">
            Transparent platform fees and direct customer connection.
          </Card>
          <Card title="Nearby Alerts">Receive job alerts in your selected radius.</Card>
          <Card title="Build Reputation">Ratings and completion stats increase demand.</Card>
        </div>
        <div className="mt-8">
          <Link
            href="/worker/dashboard"
            className="rounded-xl bg-secondary px-5 py-3 text-sm font-bold text-white"
          >
            Open Worker Dashboard Demo
          </Link>
        </div>
      </section>
      <Footer />
    </main>
  );
}

function Card({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <div className="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
      <p className="text-lg font-extrabold text-slate-900">{title}</p>
      <p className="mt-2 text-sm text-slate-600">{children}</p>
    </div>
  );
}
