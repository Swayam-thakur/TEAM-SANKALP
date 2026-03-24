"use client";

import { StatusPill } from "@/components/shared/status-pill";
import { workers } from "@/lib/data/mock";
import { MatchingState } from "@/lib/types";
import { Clock3, IndianRupee, MapPin, UserRound } from "lucide-react";
import { useEffect, useMemo, useState } from "react";

interface RequestListItem {
  id: string;
  payload: {
    category: string;
    description: string;
    location: string;
    customerName: string;
  };
  computed: {
    state: MatchingState;
  };
}

interface ListResponse {
  items: RequestListItem[];
  summary: {
    total: number;
    activeMatching: number;
    completed: number;
    failed: number;
  };
}

export function IncomingJobs() {
  const [data, setData] = useState<ListResponse | null>(null);
  const [loading, setLoading] = useState(true);
  const [actionLoading, setActionLoading] = useState<string | null>(null);

  async function load() {
    const res = await fetch("/api/demo/request", { cache: "no-store" });
    const json = (await res.json()) as ListResponse;
    setData(json);
    setLoading(false);
  }

  useEffect(() => {
    load();
    const id = setInterval(load, 4000);
    return () => clearInterval(id);
  }, []);

  const incoming = useMemo(
    () =>
      (data?.items ?? []).filter(
        (item) => item.computed.state === "SEARCHING" || item.computed.state === "ALERT_SENT"
      ),
    [data]
  );

  async function decide(requestId: string, action: "accept" | "decline") {
    setActionLoading(requestId + action);
    await fetch(`/api/demo/request/${requestId}`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ action, workerId: workers[0].id })
    });
    setActionLoading(null);
    await load();
  }

  if (loading) {
    return <p className="text-sm text-slate-500">Loading incoming jobs...</p>;
  }

  return (
    <div className="space-y-3">
      {incoming.length === 0 ? (
        <div className="rounded-2xl border border-slate-200 bg-slate-50 p-4">
          <p className="font-semibold text-slate-700">No incoming alerts right now</p>
          <p className="text-sm text-slate-500">Keep availability ON. New jobs will appear here.</p>
        </div>
      ) : null}

      {incoming.map((job) => (
        <div key={job.id} className="rounded-2xl border-2 border-energy/20 bg-white p-4 shadow-sm">
          <div className="flex items-center justify-between gap-2">
            <p className="text-sm font-bold text-slate-900">{job.payload.category}</p>
            <StatusPill state={job.computed.state} />
          </div>
          <p className="mt-1 text-sm text-slate-600">{job.payload.description}</p>
          <div className="mt-3 grid gap-2 text-sm text-slate-700 md:grid-cols-2">
            <p className="inline-flex items-center gap-2">
              <UserRound className="h-4 w-4 text-brand" />
              Customer: {job.payload.customerName}
            </p>
            <p className="inline-flex items-center gap-2">
              <MapPin className="h-4 w-4 text-brand" />
              {job.payload.location}
            </p>
            <p className="inline-flex items-center gap-2">
              <IndianRupee className="h-4 w-4 text-brand" /> Est. payout: Rs 600-900
            </p>
            <p className="inline-flex items-center gap-2">
              <Clock3 className="h-4 w-4 text-brand" /> Accept within 30 seconds
            </p>
          </div>

          <div className="mt-4 grid grid-cols-2 gap-2">
            <button
              onClick={() => decide(job.id, "accept")}
              disabled={actionLoading !== null}
              className="rounded-xl bg-trust px-4 py-2 text-sm font-bold text-white disabled:opacity-60"
            >
              {actionLoading === job.id + "accept" ? "Accepting..." : "ACCEPT"}
            </button>
            <button
              onClick={() => decide(job.id, "decline")}
              disabled={actionLoading !== null}
              className="rounded-xl border border-slate-300 bg-white px-4 py-2 text-sm font-bold text-slate-700 disabled:opacity-60"
            >
              {actionLoading === job.id + "decline" ? "Declining..." : "DECLINE"}
            </button>
          </div>
        </div>
      ))}
    </div>
  );
}
