import { MatchingState } from "@/lib/types";
import { cn } from "@/lib/utils/cn";

const statusColor: Record<MatchingState, string> = {
  REQUEST_PLACED: "bg-brand-light text-brand-dark",
  SEARCHING: "bg-amber-100 text-amber-800",
  ALERT_SENT: "bg-orange-100 text-orange-800",
  WORKER_ACCEPTED: "bg-green-100 text-green-800",
  ON_THE_WAY: "bg-cyan-100 text-cyan-800",
  JOB_STARTED: "bg-indigo-100 text-indigo-800",
  JOB_COMPLETED: "bg-emerald-100 text-emerald-800",
  NO_WORKER_FOUND: "bg-red-100 text-red-800",
  WORKER_CANCELLED: "bg-rose-100 text-rose-800"
};

export function StatusPill({ state }: { state: MatchingState }) {
  return (
    <span className={cn("rounded-full px-3 py-1 text-xs font-bold", statusColor[state])}>
      {state.replaceAll("_", " ")}
    </span>
  );
}
