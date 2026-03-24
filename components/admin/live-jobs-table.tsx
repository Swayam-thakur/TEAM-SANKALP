"use client";

import { StatusPill } from "@/components/shared/status-pill";
import { MatchingState } from "@/lib/types";
import { useEffect, useState } from "react";

interface RequestListItem {
  id: string;
  payload: {
    category: string;
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

export function LiveJobsTable() {
  const [data, setData] = useState<ListResponse | null>(null);

  async function load() {
    const res = await fetch("/api/demo/request", { cache: "no-store" });
    const json = (await res.json()) as ListResponse;
    setData(json);
  }

  useEffect(() => {
    load();
    const id = setInterval(load, 4000);
    return () => clearInterval(id);
  }, []);

  if (!data) {
    return <p className="text-sm text-slate-500">Loading admin feed...</p>;
  }

  return (
    <div className="overflow-x-auto rounded-2xl border border-slate-200 bg-white">
      <table className="min-w-full text-left text-sm">
        <thead className="bg-slate-50 text-slate-600">
          <tr>
            <th className="px-4 py-3">Request ID</th>
            <th className="px-4 py-3">Customer</th>
            <th className="px-4 py-3">Category</th>
            <th className="px-4 py-3">Location</th>
            <th className="px-4 py-3">Status</th>
          </tr>
        </thead>
        <tbody>
          {data.items.length === 0 ? (
            <tr>
              <td className="px-4 py-4 text-slate-500" colSpan={5}>
                No requests yet. Create one from customer flow.
              </td>
            </tr>
          ) : null}

          {data.items.map((item) => (
            <tr key={item.id} className="border-t border-slate-100">
              <td className="px-4 py-3 font-mono text-xs">{item.id}</td>
              <td className="px-4 py-3">{item.payload.customerName}</td>
              <td className="px-4 py-3">{item.payload.category}</td>
              <td className="px-4 py-3">{item.payload.location}</td>
              <td className="px-4 py-3">
                <StatusPill state={item.computed.state} />
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
