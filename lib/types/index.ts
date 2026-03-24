export type MatchingState =
  | "REQUEST_PLACED"
  | "SEARCHING"
  | "ALERT_SENT"
  | "WORKER_ACCEPTED"
  | "ON_THE_WAY"
  | "JOB_STARTED"
  | "JOB_COMPLETED"
  | "NO_WORKER_FOUND"
  | "WORKER_CANCELLED";

export interface Worker {
  id: string;
  name: string;
  category: string;
  rating: number;
  completedJobs: number;
  distanceKm: number;
  etaMins: number;
  verified: boolean;
  languages: string[];
  ratePerHour: number;
  city: string;
}

export interface RequestPayload {
  customerName: string;
  category: string;
  description: string;
  location: string;
  budgetMax?: number;
  preferredLanguage?: string;
}

export interface DemoRequestRecord {
  id: string;
  createdAt: number;
  payload: RequestPayload;
  forcedOutcome?: "success" | "no_worker";
  acceptedWorkerId?: string;
  acceptedAt?: number;
  cancelledByWorkerAt?: number;
}

export interface TrackingStateResponse {
  requestId: string;
  state: MatchingState;
  headline: string;
  subtext: string;
  supportingInfo?: string;
  workerCountChecked?: number;
  alertedWorkerCount?: number;
  radiusKm?: number;
  worker?: Worker;
  etaMins?: number;
  elapsedSeconds: number;
}
