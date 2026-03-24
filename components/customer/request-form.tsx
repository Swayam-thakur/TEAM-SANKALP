"use client";

import { serviceCategories } from "@/lib/data/mock";
import { useRouter } from "next/navigation";
import { FormEvent, useMemo, useState } from "react";

interface Props {
  compact?: boolean;
}

export function RequestForm({ compact = false }: Props) {
  const router = useRouter();
  const [category, setCategory] = useState("Plumbing");
  const [description, setDescription] = useState("Fix leaking pipe under kitchen sink");
  const [location, setLocation] = useState("HSR Layout, Bengaluru");
  const [customerName, setCustomerName] = useState("Aditi");
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const isValid = useMemo(
    () => category.trim() && description.trim().length >= 8 && location.trim().length >= 3,
    [category, description, location]
  );

  async function handleSubmit(event: FormEvent) {
    event.preventDefault();
    if (!isValid) return;
    setError(null);
    setSubmitting(true);

    try {
      const response = await fetch("/api/demo/request", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ category, description, location, customerName })
      });
      const json = (await response.json()) as { requestId?: string; error?: string };
      if (!response.ok || !json.requestId) {
        throw new Error(json.error ?? "Unable to create request.");
      }
      router.push(`/app/request/${json.requestId}/tracking`);
    } catch (err) {
      setError(err instanceof Error ? err.message : "Something went wrong.");
      setSubmitting(false);
    }
  }

  return (
    <form
      onSubmit={handleSubmit}
      className="space-y-3 rounded-2xl border border-slate-200 bg-white p-4 shadow-md md:p-5"
    >
      <div className={compact ? "grid gap-3 md:grid-cols-3" : "grid gap-3"}>
        <label className="text-sm font-semibold text-slate-700">
          Service
          <select
            value={category}
            onChange={(e) => setCategory(e.target.value)}
            className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm"
          >
            {serviceCategories.map((item) => (
              <option key={item} value={item}>
                {item}
              </option>
            ))}
          </select>
        </label>

        <label className="text-sm font-semibold text-slate-700">
          Location
          <input
            value={location}
            onChange={(e) => setLocation(e.target.value)}
            className="mt-1 w-full rounded-xl border border-slate-300 px-3 py-2 text-sm"
            placeholder="Area, City"
          />
        </label>

        <label className="text-sm font-semibold text-slate-700">
          Name
          <input
            value={customerName}
            onChange={(e) => setCustomerName(e.target.value)}
            className="mt-1 w-full rounded-xl border border-slate-300 px-3 py-2 text-sm"
          />
        </label>
      </div>

      <label className="block text-sm font-semibold text-slate-700">
        Job description
        <textarea
          value={description}
          onChange={(e) => setDescription(e.target.value)}
          rows={3}
          className="mt-1 w-full rounded-xl border border-slate-300 px-3 py-2 text-sm"
          placeholder="Describe the issue with landmarks and urgency"
        />
      </label>

      {error ? <p className="text-sm text-danger">{error}</p> : null}

      <button
        type="submit"
        disabled={!isValid || submitting}
        className="w-full rounded-xl bg-brand px-4 py-3 text-sm font-bold text-white shadow-primary transition hover:bg-brand-dark disabled:cursor-not-allowed disabled:bg-slate-300"
      >
        {submitting ? "Finding Nearby Workers..." : "Find Worker Now"}
      </button>
    </form>
  );
}
