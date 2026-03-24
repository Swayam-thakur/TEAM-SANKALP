import { getTrackingState, workerDecision } from "@/lib/matching-engine";
import { NextRequest, NextResponse } from "next/server";

interface Params {
  params: {
    id: string;
  };
}

export async function GET(_: NextRequest, { params }: Params) {
  const state = getTrackingState(params.id);
  if (!state) {
    return NextResponse.json({ error: "Request not found." }, { status: 404 });
  }
  return NextResponse.json(state);
}

export async function POST(req: NextRequest, { params }: Params) {
  const body = (await req.json()) as {
    action?: "accept" | "decline";
    workerId?: string;
  };

  if (!body.action) {
    return NextResponse.json({ error: "action is required." }, { status: 400 });
  }

  const nextState = workerDecision(params.id, body.action, body.workerId);
  if (!nextState) {
    return NextResponse.json({ error: "Request not found." }, { status: 404 });
  }
  return NextResponse.json(nextState);
}
