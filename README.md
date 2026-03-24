QuickSeva

QuickSeva is a real-time service marketplace connecting daily wage workers (plumbers, electricians, painters, mazdoors) with nearby users who need immediate help.

It includes:

📱 Flutter Android App (User + Worker)
🌐 Web Application (User/Admin)
🔥 Firebase Backend (Auth, DB, Notifications)
🌍 Multi-language Support (English, Hindi, Marathi)
👥 Team Sankalp

Project Title: QuickSeva - Real-Time Service Marketplace
Problem Statement: TGPDS-02 (RozgarSaathi)

Team Members:
Swayam Thakur
Janhavi Deshmukh
Shravan Pawar
Sujal Gabhane
❗ Problem Statement

Daily wage workers often:

Wait at local nakas for work
Lack digital visibility
Lose time and income opportunities

Users:

Struggle to find reliable workers quickly
Face delays and middlemen issues
💡 Solution

QuickSeva provides:

A hyperlocal gig platform
Real-time worker matching (like Ola/Uber)
Direct connection without middlemen
✨ Features
🔹 Core Features
User & Worker Registration
Post Same-Day Jobs
Real-time Nearby Worker Matching
Job Acceptance & Tracking
Ratings & Reviews
🔹 Mobile App Features
Firebase OTP Authentication
Worker Request Alerts
Chat System
Booking Flow
Payment (Placeholder)
Worker Availability Toggle
🔹 Web Features
Job Posting Dashboard
Worker Listings
Admin Monitoring Panel
🌍 Multilingual Support
English 🇬🇧
Hindi 🇮🇳
Marathi 🇮🇳

Users can switch language dynamically from UI.

🛠️ Tech Stack
🔹 Frontend
Web: React.js / Next.js
Mobile: Flutter
🔹 Backend
Firebase (Primary Backend)
Authentication (OTP Login)
Firestore Database
Cloud Functions
Firebase Cloud Messaging (FCM)
🔹 APIs & Services
Google Maps API (Location & Distance)
Real-time updates using Firebase
📱 Mobile App Structure
lib/
android/
functions/
assets/mock/
Features Included:
User + Worker flows
Firebase integration
Booking system
Notifications
Chat & Ratings
⚙️ Mobile Setup
Install Flutter & Android Studio

Run:

flutter pub get

Configure Firebase:

flutterfire configure

Add:

android/app/google-services.json

Set API key:

MAPS_API_KEY in android/local.properties

Deploy Firebase (if needed):

firebase deploy

Run app:

flutter run
🌐 Web/Admin Structure
app/
components/
backend/
Existing codebase preserved from repository
Connected to Firebase backend
Handles job posting & admin control
🔄 How System Works
User posts a job
Nearby workers get instant alert
Worker accepts request
Job gets completed
Rating & feedback submitted
📍 Key Innovation
Uber-like worker matching
Hyperlocal job discovery
No middlemen / zero commission
Multi-language accessibility
🚀 Future Scope
Online payments integration
AI-based worker recommendations
Voice-based job posting (local languages)
Worker verification system
Expansion to more cities
📈 Impact & Benefits
For Workers:
More job opportunities
Reduced idle time
Direct earnings
For Users:
Faster service access
Reliable workers nearby
Transparent process
🏁 Conclusion

QuickSeva aims to digitize local labor markets, making services faster, fairer, and more accessible for both workers and users.
