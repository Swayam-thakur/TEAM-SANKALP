# QuickSeva Hackathon MVP

Hackathon-ready Next.js app for:
- Public marketing website
- Customer app (request + live tracking)
- Worker app (incoming alert accept/decline)
- Admin dashboard (live feed)

## Team Sankalp (TechKruti 2K26)

- Project Title: QuickSeva - Real-Time Service Marketplace
- Problem Statement: TGPDS-02 (RozgarSaathi)
- Core Context: Blue-collar workers (plumbers, electricians, painters, mazdoors) need same-day digital visibility without middlemen.
- Team Members:
  - Swayam Thakur (Leader)
  - Janhavi Deshmukh
  - Shravan Pawar
  - Sujal Gabhane
 
System Architecture:

        ┌──────────────────────┐
        │     Web App (React)  │
        └──────────┬───────────┘
                   │
        ┌──────────▼───────────┐
        │  Mobile App (Flutter)│
        └──────────┬───────────┘
                   │
           (API Requests)
                   │
        ┌──────────▼───────────┐
        │   Backend (Node.js)  │
        │   Express Server     │
        └──────────┬───────────┘
                   │
     ┌─────────────▼────────────┐
     │        Firebase          │
     │  - Authentication        │
     │  - Firestore Database    │
     │  - Cloud Messaging (FCM) │
     └─────────────┬────────────┘
                   │
        ┌──────────▼───────────┐
        │ Google Maps API      │
        │ (Location Matching)  │
        └──────────────────────┘
