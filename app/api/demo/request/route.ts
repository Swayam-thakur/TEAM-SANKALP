import { createDemoRequest, listDemoRequests } from "@/lib/matching-engine";
import { RequestPayload } from "@/lib/types";
import { NextRequest, NextResponse } from "next/server";

export async function GET() {
  const requests = listDemoRequests();
  return NextResponse.json({
    items: requests,
    summary: {
      total: requests.length,
      activeMatching: requests.filter(
        (r) => r.computed.state === "SEARCHING" || r.computed.state === "ALERT_SENT"
      ).length,
      completed: requests.filter((r) => r.computed.state === "JOB_COMPLETED").length,
      failed: requests.filter((r) => r.computed.state === "NO_WORKER_FOUND").length
    }
  });
}

export async function POST(req: NextRequest) {
  const payload = (await req.json()) as RequestPayload;

  if (!payload.category || !payload.description || !payload.location) {
    return NextResponse.json(
      { error: "category, description and location are required." },
      { status: 400 }
    );
  }

  const record = createDemoRequest(payload);
  return NextResponse.json({ requestId: record.id }, { status: 201 });
}
