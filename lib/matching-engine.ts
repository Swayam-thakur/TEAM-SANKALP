import { workers } from "@/lib/data/mock";
import {
  DemoRequestRecord,
  RequestPayload,
  TrackingStateResponse,
  Worker
} from "@/lib/types";

const requestStore = globalThis as unknown as {
  quickSevaRequestMap?: Map<string, DemoRequestRecord>;
};

if (!requestStore.quickSevaRequestMap) {
  requestStore.quickSevaRequestMap = new Map<string, DemoRequestRecord>();
}

const requests = requestStore.quickSevaRequestMap;

function generateId() {
  return `req_${Math.random().toString(36).slice(2, 10)}`;
}

function pickWorker(category: string): Worker | undefined {
  const exact = workers.find((w) => w.category.toLowerCase() === category.toLowerCase());
  return exact ?? workers[Math.floor(Math.random() * workers.length)];
}

function timelineFor(record: DemoRequestRecord, now = Date.now()): TrackingStateResponse {
  const elapsed = Math.floor((now - record.createdAt) / 1000);
  const forcedNoWorker =
    record.forcedOutcome === "no_worker" ||
    record.payload.location.toLowerCase().includes("remote");
  const worker = record.acceptedWorkerId
    ? workers.find((w) => w.id === record.acceptedWorkerId)
    : pickWorker(record.payload.category);

  if (forcedNoWorker && elapsed > 35) {
    return {
      requestId: record.id,
      state: "NO_WORKER_FOUND",
      headline: "No workers available right now",
      subtext: "Try again, schedule for later, or expand your search radius.",
      supportingInfo: "You can also enable 'Notify me when available'.",
      elapsedSeconds: elapsed
    };
  }

  if (record.cancelledByWorkerAt && now > record.cancelledByWorkerAt) {
    return {
      requestId: record.id,
      state: "WORKER_CANCELLED",
      headline: "Worker had to cancel. Finding you another...",
      subtext: "Auto-rematch is in progress.",
      supportingInfo: "We are prioritizing verified workers for this retry.",
      elapsedSeconds: elapsed
    };
  }

  if (elapsed <= 4) {
    return {
      requestId: record.id,
      state: "REQUEST_PLACED",
      headline: "Your request is placed. Finding nearby workers...",
      subtext: "We are preparing the first matching wave.",
      workerCountChecked: 0,
      elapsedSeconds: elapsed
    };
  }

  if (elapsed <= 14) {
    return {
      requestId: record.id,
      state: "SEARCHING",
      headline: "Searching for available workers near you...",
      subtext: "Checking workers in your 1 km radius.",
      workerCountChecked: 12,
      radiusKm: 1,
      elapsedSeconds: elapsed
    };
  }

  if (elapsed <= 24) {
    return {
      requestId: record.id,
      state: "ALERT_SENT",
      headline: "Request sent to nearby workers",
      subtext: "Waiting for quick responses from your area.",
      alertedWorkerCount: 8,
      radiusKm: 2,
      elapsedSeconds: elapsed
    };
  }

  if (elapsed <= 54) {
    return {
      requestId: record.id,
      state: "WORKER_ACCEPTED",
      headline: `Great! ${worker?.name ?? "A worker"} has accepted your request`,
      subtext: `${worker?.rating ?? 4.7}★ rated professional confirmed.`,
      worker,
      etaMins: worker?.etaMins ?? 16,
      elapsedSeconds: elapsed
    };
  }

  if (elapsed <= 89) {
    return {
      requestId: record.id,
      state: "ON_THE_WAY",
      headline: `${worker?.name ?? "Worker"} is on the way`,
      subtext: `${Math.max((worker?.etaMins ?? 14) - 3, 3)} min away`,
      worker,
      etaMins: Math.max((worker?.etaMins ?? 14) - 3, 3),
      elapsedSeconds: elapsed
    };
  }

  if (elapsed <= 130) {
    return {
      requestId: record.id,
      state: "JOB_STARTED",
      headline: "Work in progress",
      subtext: "Started at the customer location.",
      worker,
      elapsedSeconds: elapsed
    };
  }

  return {
    requestId: record.id,
    state: "JOB_COMPLETED",
    headline: "Job completed! How did it go?",
    subtext: "Proceed to secure payment and rating.",
    worker,
    elapsedSeconds: elapsed
  };
}

export function createDemoRequest(payload: RequestPayload): DemoRequestRecord {
  const id = generateId();
  const record: DemoRequestRecord = {
    id,
    createdAt: Date.now(),
    payload,
    forcedOutcome: payload.location.toLowerCase().includes("remote")
      ? "no_worker"
      : "success"
  };
  requests.set(id, record);
  return record;
}

export function getDemoRequest(id: string): DemoRequestRecord | undefined {
  return requests.get(id);
}

export function listDemoRequests() {
  return Array.from(requests.values()).map((record) => ({
    ...record,
    computed: timelineFor(record)
  }));
}

export function getTrackingState(id: string): TrackingStateResponse | null {
  const record = requests.get(id);
  if (!record) return null;
  return timelineFor(record);
}

export function workerDecision(
  id: string,
  action: "accept" | "decline",
  workerId?: string
): TrackingStateResponse | null {
  const record = requests.get(id);
  if (!record) return null;

  if (action === "accept") {
    record.acceptedWorkerId = workerId ?? pickWorker(record.payload.category)?.id;
    record.createdAt = Date.now() - 25_000;
  } else {
    record.forcedOutcome = "no_worker";
    record.createdAt = Date.now() - 36_000;
  }
  requests.set(id, record);
  return timelineFor(record);
}
