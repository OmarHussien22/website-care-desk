# MedDesk website integration

The website was verified against the Laravel project at
`/Users/fathy/Documents/Omar/clinic-system/backend` and the dashboard at
`/Users/fathy/Documents/Omar/clinic-system/dashboard`.

## Verified contracts

- API base: `/api/v1`
- Public pricing: `GET /api/v1/website/plans`
- Public specialties: `GET /api/v1/website/specialties`
- Public clinic registration: `POST /api/v1/website/register`
- Clinic login: `POST /api/v1/clinic/login`
- Clinic dashboard route: `/clinic`
- Clinic creation business logic: `ClinicService::create()`
- Plan resource fields: name, price, currency, duration, discount, features,
  and limits
- Specialty resource fields: id, Arabic/English name, key, status, and
  description

## Registration ownership

The website registration endpoint validates website input and delegates clinic
creation to the existing `ClinicService::create()` method. Laravel remains the
source of truth for user creation, clinic ownership, API-key generation, and
the default active trial plan and duration. The public response deliberately
does not expose the generated API key.

Plans and specialties are filtered to active records by the existing backend
services. Validation responses use the standard `{status, message, data}`
envelope and return localized duplicate-phone, duplicate-email, and invalid-
specialty messages according to `Accept-Language`.

No public contact endpoint exists, so the contact form remains an honest UI-
ready state and does not simulate a successful submission.

The route defaults are already configured. Override deployment URLs when
building for staging or production:

```bash
flutter build web \
  --dart-define=MEDDESK_API_BASE_URL=https://api.example.com/api/v1/ \
  --dart-define=MEDDESK_DASHBOARD_BASE_URL=https://app.example.com
```
