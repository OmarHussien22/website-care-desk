# MedDesk website

A responsive Flutter marketing and clinic registration website for the companion
`clinic-system` backend and dashboard. Arabic is the default language; English
and right-to-left layouts are supported.

## Run locally

```sh
flutter pub get
flutter run -d chrome --web-port 8088
```

The default backend is `http://127.0.0.1:8000/api/v1/` and the dashboard is
`http://localhost:3000`. Start those applications from the companion project
when testing live plans, specialties, registration, and dashboard login.

## Production build

Set the deployment URLs explicitly:

```sh
flutter build web --release \
  --dart-define=MEDDESK_API_BASE_URL=https://api.example.com/api/v1/ \
  --dart-define=MEDDESK_DASHBOARD_BASE_URL=https://dashboard.example.com
```

Serve `build/web/` using your existing Flutter hosting setup. Public onboarding
uses `/website/plans`, `/website/specialties`, and `/website/register` relative
to the API base. Successful registration opens `/clinic/login` on the configured
dashboard. Configure backend CORS for the deployed website origin.

## Design and performance

- Shared teal, mint, surface, typography, and responsive spacing tokens.
- Responsive floating navigation and matching clinic registration page.
- Lightweight vector workspace previews with no external image requests.
- One-time scroll reveals, isolated preview repaints, and throttled section tracking.
- Reduced-motion support for reveals, scrolling, hover effects, and the product tour.
- A small branded startup screen while Flutter initializes.
- Only the four used weights per font family are registered and bundled.

The workspace previews show illustrative data. Pricing and signup use the backend;
no demo account is created by the website itself.

## Verification

```sh
flutter test
flutter analyze lib test
flutter build web --release
```

Tests cover bilingual layouts from 320px to desktop, reduced motion, mobile menu
navigation, registration routing, plan parsing, and phone formatting. Full-project
analysis may also include existing generated iOS dependency examples under `build/`.
