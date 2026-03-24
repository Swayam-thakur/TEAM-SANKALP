import { TrackingPanel } from "@/components/customer/tracking-panel";
import { Footer } from "@/components/shared/footer";
import { Navbar } from "@/components/shared/navbar";
import Link from "next/link";

interface Props {
  params: {
    requestId: string;
  };
}

export default function RequestTrackingPage({ params }: Props) {
  return (
    <main>
      <Navbar />
      <section className="container-width py-10">
        <div className="mb-4 flex flex-wrap items-center justify-between gap-2">
          <div>
            <p className="text-sm font-semibold text-brand">Real-Time Tracking</p>
            <h1 className="text-3xl font-extrabold text-slate-950">Track Your Request Live</h1>
          </div>
          <Link
            href="/app/request/new"
            className="rounded-lg border border-slate-300 px-3 py-2 text-sm font-semibold text-slate-700"
          >
            Create Another Request
          </Link>
        </div>

        <TrackingPanel requestId={params.requestId} />
      </section>
      <Footer />
    </main>
  );
}
