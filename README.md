# QuickSeva

QuickSeva includes both:
- a Flutter Android app for user/worker mobile flows
- an existing web/admin codebase already present in the GitHub repository

## Team Sankalp

- Project Title: QuickSeva - Real-Time Service Marketplace
- Problem Statement: TGPDS-02 (RozgarSaathi)
- Team Members:
  - Swayam Thakur
  - Janhavi Deshmukh
  - Shravan Pawar
  - Sujal Gabhane

## Mobile App

The Flutter mobile app is Android-first and includes:
- user app flow
- worker app flow
- Firebase auth
- bookings
- worker request alerts
- chat
- payments placeholder
- ratings
- Firebase-backed repositories and rules

Main mobile app folders:

```text
lib/
android/
functions/
assets/mock/
```

## Mobile Setup

1. Install Flutter and Android toolchain
2. Run `flutter pub get`
3. Configure Firebase with `flutterfire configure`
4. Add `android/app/google-services.json`
5. Set `MAPS_API_KEY` in `android/local.properties`
6. Deploy Firebase rules/functions if needed
7. Run `flutter run`

## Web/Admin

The repository also contains an existing web/admin application under:

```text
app/
components/
backend/
```

That code was already present on the GitHub repository and has been preserved during merge.
