import { Footer } from "@/components/shared/footer";
import { Navbar } from "@/components/shared/navbar";

export default function HowItWorksPage() {
  return (
    <main>
      <Navbar />
      <section className="container-width py-12">
        <h1 className="text-4xl font-extrabold text-slate-950">How QuickSeva Works</h1>
        <p className="mt-2 text-slate-600">
          Real-time dual-path flow designed for customers and workers in Indian cities.
        </p>

        <div className="mt-8 grid gap-4 md:grid-cols-2">
          <div className="rounded-2xl border border-slate-200 bg-white p-5">
            <h2 className="text-2xl font-extrabold text-brand-dark">For Customers</h2>
            <ol className="mt-3 space-y-2 text-sm text-slate-700">
              <li>1. Post request with service, location and urgency.</li>
              <li>2. Platform broadcasts to nearby qualified workers.</li>
              <li>3. First suitable worker accepts and shares ETA.</li>
              <li>4. Track job live, pay digitally, rate experience.</li>
            </ol>
          </div>
          <div className="rounded-2xl border border-slate-200 bg-white p-5">
            <h2 className="text-2xl font-extrabold text-secondary">For Workers</h2>
            <ol className="mt-3 space-y-2 text-sm text-slate-700">
              <li>1. Turn availability ON to receive local alerts.</li>
              <li>2. Accept jobs in one tap with clear payout estimate.</li>
              <li>3. Navigate, complete work and mark status in app.</li>
              <li>4. Get paid via UPI and build repeat customer base.</li>
            </ol>
          </div>
        </div>
      </section>
      <Footer />
    </main>
  );
}
