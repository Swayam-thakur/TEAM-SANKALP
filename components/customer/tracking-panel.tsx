"use client";

import { StatusPill } from "@/components/shared/status-pill";
import { MatchingState, TrackingStateResponse } from "@/lib/types";
import { Clock3, MapPin, Phone, RefreshCw, Star, User } from "lucide-react";
import { useEffect, useMemo, useState } from "react";

const stateOrder: MatchingState[] = [
  "REQUEST_PLACED",
  "SEARCHING",
  "ALERT_SENT",
  "WORKER_ACCEPTED",
  "ON_THE_WAY",
  "JOB_STARTED",
  "JOB_COMPLETED"
];

interface Props {
  requestId: string;
}

export function TrackingPanel({ requestId }: Props) {
  const [data, setData] = useState<TrackingStateResponse | null>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let mounted = true;
    const fetchState = async () => {
      try {
        const res = await fetch(`/api/demo/request/${requestId}`, { cache: "no-store" });
        const json = (await res.json()) as TrackingStateResponse | { error?: string };
        if (!res.ok || "error" in json) {
          throw new Error("error" in json ? json.error : "Unable to fetch tracking state.");
        }
        if (mounted) setData(json);
      } catch (err) {
        if (mounted) setError(err instanceof Error ? err.message : "Tracking failed.");
      }
    };

    fetchState();
    const id = setInterval(fetchState, 3000);
    return () => {
      mounted = false;
      clearInterval(id);
    };
  }, [requestId]);

  const progress = useMemo(() => {
    if (!data) return 0;
    const index = stateOrder.findIndex((s) => s === data.state);
    if (index === -1) return 20;
    return ((index + 1) / stateOrder.length) * 100;
  }, [data]);

  if (error) {
    return (
      <div className="rounded-2xl border border-red-200 bg-red-50 p-5 text-red-700">
        <p className="font-semibold">Tracking unavailable</p>
        <p className="text-sm">{error}</p>
      </div>
    );
  }

  if (!data) {
    return (
      <div className="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
        <p className="animate-pulse text-slate-600">Loading live request state...</p>
      </div>
    );
  }

  return (
    <div className="space-y-4">
      <div className="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
        <div className="flex flex-wrap items-center justify-between gap-3">
          <div>
            <p className="text-sm text-slate-500">Request ID</p>
            <p className="font-bold text-slate-900">{data.requestId}</p>
          </div>
          <StatusPill state={data.state} />
        </div>

        <div className="mt-4 h-2 w-full rounded-full bg-slate-200">
          <div
            className="h-2 rounded-full bg-brand transition-all duration-700"
            style={{ width: `${progress}%` }}
          />
        </div>

        <h2 className="mt-5 text-2xl font-extrabold text-slate-950">{data.headline}</h2>
        <p className="mt-1 text-slate-600">{data.subtext}</p>
        {data.supportingInfo ? <p className="mt-1 text-sm text-slate-500">{data.supportingInfo}</p> : null}

        <div className="mt-4 grid gap-3 md:grid-cols-3">
          <div className="rounded-xl border border-slate-200 p-3">
            <p className="text-xs text-slate-500">Elapsed</p>
            <p className="text-sm font-bold">{data.elapsedSeconds}s</p>
          </div>
          <div className="rounded-xl border border-slate-200 p-3">
            <p className="text-xs text-slate-500">Checked</p>
            <p className="text-sm font-bold">{data.workerCountChecked ?? "-"}</p>
          </div>
          <div className="rounded-xl border border-slate-200 p-3">
            <p className="text-xs text-slate-500">Alerted</p>
            <p className="text-sm font-bold">{data.alertedWorkerCount ?? "-"}</p>
          </div>
        </div>
      </div>

      {data.worker ? (
        <div className="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
          <p className="text-sm font-semibold text-slate-500">Assigned worker</p>
          <div className="mt-3 grid gap-3 md:grid-cols-2">
            <div className="rounded-xl border border-slate-200 p-3">
              <div className="flex items-center gap-2">
                <User className="h-4 w-4 text-brand" />
                <p className="font-semibold">{data.worker.name}</p>
              </div>
              <p className="text-sm text-slate-600">{data.worker.category}</p>
            </div>
            <div className="rounded-xl border border-slate-200 p-3">
              <div className="flex items-center gap-2 text-sm text-slate-700">
                <Star className="h-4 w-4 text-yellow-500" /> {data.worker.rating} rating
              </div>
              <div className="mt-1 flex items-center gap-2 text-sm text-slate-700">
                <MapPin className="h-4 w-4 text-brand" /> {data.worker.distanceKm} km
              </div>
              <div className="mt-1 flex items-center gap-2 text-sm text-slate-700">
                <Clock3 className="h-4 w-4 text-brand" /> {data.etaMins ?? data.worker.etaMins} mins ETA
              </div>
            </div>
          </div>

          <div className="mt-4 flex flex-wrap gap-2">
            <button className="inline-flex items-center gap-2 rounded-lg bg-brand px-4 py-2 text-sm font-semibold text-white">
              <Phone className="h-4 w-4" /> Call Worker
            </button>
            <button className="inline-flex items-center gap-2 rounded-lg border border-slate-300 px-4 py-2 text-sm font-semibold text-slate-700">
              <RefreshCw className="h-4 w-4" /> Refresh ETA
            </button>
          </div>
        </div>
      ) : null}
    </div>
  );
}
