export function Footer() {
  return (
    <footer className="mt-24 border-t border-slate-200 bg-white">
      <div className="container-width grid gap-6 py-10 text-sm text-slate-600 md:grid-cols-4">
        <div>
          <p className="text-base font-bold text-slate-950">QuickSeva</p>
          <p className="mt-2">Service, Right Here. Right Now.</p>
        </div>
        <div>
          <p className="font-semibold text-slate-900">Customers</p>
          <p className="mt-2">Find nearby verified workers instantly.</p>
        </div>
        <div>
          <p className="font-semibold text-slate-900">Workers</p>
          <p className="mt-2">Get jobs directly. No middlemen.</p>
        </div>
        <div>
          <p className="font-semibold text-slate-900">Hackathon Build</p>
          <p className="mt-2">MVP demo optimized for speed.</p>
        </div>
      </div>
    </footer>
  );
}
