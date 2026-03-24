import { RequestForm } from "@/components/customer/request-form";
import { Footer } from "@/components/shared/footer";
import { Navbar } from "@/components/shared/navbar";

export default function NewRequestPage() {
  return (
    <main>
      <Navbar />
      <section className="container-width py-10">
        <p className="text-sm font-semibold text-brand">Instant Request Wizard (Hackathon MVP)</p>
        <h1 className="mt-1 text-3xl font-extrabold text-slate-950">Create Service Request</h1>
        <p className="mt-2 max-w-3xl text-slate-600">
          This form is optimized for demo speed. It creates a live request and redirects to a real-time
          tracking timeline with all core states.
        </p>

        <div className="mt-6 grid gap-4 md:grid-cols-[1.1fr,0.9fr]">
          <RequestForm />

          <div className="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
            <p className="font-bold text-slate-900">6-Step Full Spec (included in production)</p>
            <ol className="mt-3 space-y-2 text-sm text-slate-700">
              <li>1. Service details (category, sub-service, photos, duration)</li>
              <li>2. Location (map pin, address, landmark, floor)</li>
              <li>3. Timing (Now / Schedule / Flexible today)</li>
              <li>4. Budget (range + negotiable mode)</li>
              <li>5. Preferences (favorite worker, language, gender)</li>
              <li>6. Review & confirm (payment method + terms)</li>
            </ol>

            <div className="mt-4 rounded-xl border border-brand/20 bg-brand-light p-3">
              <p className="text-sm font-semibold text-brand-dark">Demo tip</p>
              <p className="text-xs text-slate-700">
                For `NO_WORKER_FOUND` state demo, set location containing the word `remote`.
              </p>
            </div>
          </div>
        </div>
      </section>
      <Footer />
    </main>
  );
}
