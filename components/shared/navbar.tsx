import Link from "next/link";

const navItems = [
  { label: "Services", href: "/services" },
  { label: "How It Works", href: "/how-it-works" },
  { label: "For Workers", href: "/for-workers" }
];

export function Navbar() {
  return (
    <header className="sticky top-0 z-50 border-b border-slate-100 bg-white/95 backdrop-blur">
      <div className="container-width flex h-16 items-center justify-between">
        <Link href="/" className="text-xl font-extrabold tracking-tight text-brand-dark">
          QuickSeva
        </Link>

        <nav className="hidden gap-7 text-sm font-semibold text-slate-700 md:flex">
          {navItems.map((item) => (
            <Link key={item.href} href={item.href} className="hover:text-brand">
              {item.label}
            </Link>
          ))}
        </nav>

        <div className="flex items-center gap-2">
          <Link
            href="/app/dashboard"
            className="rounded-full border border-slate-300 px-4 py-2 text-sm font-semibold"
          >
            Customer App
          </Link>
          <Link
            href="/worker/dashboard"
            className="rounded-full bg-brand px-4 py-2 text-sm font-semibold text-white shadow-primary"
          >
            Worker App
          </Link>
        </div>
      </div>
    </header>
  );
}
