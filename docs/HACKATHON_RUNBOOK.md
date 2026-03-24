# QuickSeva 4-Hour Hackathon Runbook

This runbook is designed for one laptop team execution under severe time pressure.

## 0) What Is Already Implemented In This Repository

- Next.js + TypeScript + Tailwind scaffold
- Public website core pages
- Customer app:
  - Dashboard
  - Search
  - Request creation
  - Live tracking states (9-state logic simulated)
- Worker app:
  - Dashboard
  - Incoming alerts with accept/decline
- Admin app:
  - Live request feed + top stats
- API routes for in-memory matching simulation
- Placeholder pages for full IA coverage (to avoid dead links)
- Prisma schema baseline for production migration planning

## 1) Critical Setup (10-20 mins)

### Windows setup (fastest path)

1. Open PowerShell as Administrator.
2. Install Node:
   ```powershell
   winget install OpenJS.NodeJS.LTS
   ```
3. Close and reopen terminal.
4. Verify:
   ```powershell
   node -v
   npm -v
   ```
5. In project root:
   ```powershell
   npm install
   npm run dev
   ```
6. Open:
   - `http://localhost:3000`

If `winget` unavailable:
1. Download Node LTS installer from nodejs.org.
2. Run installer with defaults.
3. Reopen terminal and continue.

## 2) Demo Narrative Script (for judges)

Use this exact sequence:

1. Open `/`:
   - Explain differentiator: real-time matching, no middleman, worker empowerment.
2. Click `Customer App` -> `/app/dashboard`.
3. Click `Create Instant Request` -> `/app/request/new`.
4. Submit request:
   - category: Plumbing
   - location: HSR Layout, Bengaluru
   - description: Leaking sink pipe
5. Tracking page auto-opens:
   - Show states progressing every few seconds.
6. Open new tab `/worker/dashboard`:
   - Show same request in incoming alerts.
   - Click `ACCEPT`.
7. Return to customer tracking:
   - Show accepted worker state and ETA.
8. Open `/admin/dashboard`:
   - Show request in live operations table.
9. Optional failure-state demo:
   - Create request with location containing `remote`.
   - Show `NO_WORKER_FOUND` fallback state.

## 3) Feature Completion Sprint Plan (3-4 Hours Total)

## Hour 0:00-0:45 (Must Complete)

1. Get app running (`npm install`, `npm run dev`).
2. Validate these routes manually:
   - `/`
   - `/app/dashboard`
   - `/app/request/new`
   - `/worker/dashboard`
   - `/admin/dashboard`
3. Create 1 request and ensure tracking updates.

## Hour 0:45-1:45 (High Impact UI polish)

1. Edit `app/(public)/page.tsx`:
   - Add your team name and branding.
   - Add launch city stats relevant to your pitch.
2. Edit `lib/data/mock.ts`:
   - Replace worker names/cities with your target market.
3. Edit `components/customer/request-form.tsx`:
   - Adjust default request text for your strongest category.

## Hour 1:45-2:45 (Credibility layer)

1. Add screenshots/gifs:
   - Place assets in `/public/images`.
2. Update homepage proof sections:
   - impact stats
   - testimonials snippets
3. Add one safety block in `/app/(public)/trust-safety/page.tsx`.

## Hour 2:45-3:30 (Pitch hardening)

1. Create 3 saved browser tabs for instant switching:
   - customer tracking
   - worker dashboard
   - admin dashboard
2. Prepare fallback scripted data:
   - success case
   - no-worker case
3. Record 60-second backup screen recording.

## Hour 3:30-4:00 (Final sanity)

1. Restart server once.
2. Re-run full demo script end-to-end.
3. Keep one terminal visible with logs.
4. Keep one teammate ready on worker tab.

## 4) Fast Edits You Can Make Safely

### Adjust matching speed

File: `lib/matching-engine.ts`
- Reduce timeline thresholds to speed demo if needed.

### Force success or failure for deterministic demo

File: `components/customer/request-form.tsx`
- Set location string to include `remote` for failure flow.

### Change worker who accepts

File: `components/worker/incoming-jobs.tsx`
- `workerId: workers[0].id` can be switched to other mock worker.

## 5) Common Demo Failures + Recovery

1. **`node` not found**
   - reinstall Node LTS, reopen terminal.
2. **Port 3000 busy**
   - run `npm run dev -- -p 3001`.
3. **No incoming jobs on worker dashboard**
   - create new request, wait 5-10s, refresh worker dashboard.
4. **Tracking stuck**
   - refresh `/app/request/[id]/tracking`.
5. **Styles missing**
   - ensure `app/globals.css` imports tailwind directives.

## 6) Optional Next Steps If Extra Time Appears

1. Integrate Supabase Postgres for persistence.
2. Add phone OTP auth via Firebase.
3. Add Mapbox map to tracking and search pages.
4. Add PostHog event instrumentation.

## 7) Routes Index (Pitch Sheet)

- Public: `/`, `/services`, `/how-it-works`, `/for-workers`, `/trust-safety`, `/cities`, `/faq`, `/contact`
- Customer: `/app/dashboard`, `/app/search`, `/app/request/new`, `/app/request/[id]/tracking`
- Worker: `/worker/dashboard`
- Admin: `/admin/dashboard`

Use this sheet during Q&A to jump quickly to proof screens.
