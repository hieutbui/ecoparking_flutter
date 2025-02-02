# ecoparking_flutter

An application for graduation project that has 2 main use-cases:
- User find parking lots
- Parking's owners and employees manage their parking

*Any Github Page of this project except last release will be remove from Supabase Redirect URLs after 2 days*

## Getting Started

### Flutter

Before building, please ensure that Flutter is installed in your environment.

Flutter installation doc: [Set up Flutter](https://docs.flutter.dev/get-started/install)

In case you have Flutter already installed, make sure to get all the pubspecs and generate all the needed files:

```bash
flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
```

### Supabase

This project uses Supabase as the backend service. Therefore, you need to set up a Supabase project to run it on your own.

#### Create new Supabase project

- [Create a new Supabase project](https://app.supabase.io/)
- Navigate to the [Auth settings](https://app.supabase.io/project/_/auth/settings) and turn off the toggle next to "Enable email confirmations". (Note: this is only for testing. In production please enable this setting and set up your custom SMTP!)
- Navigate to the [Supabase Vault](https://app.supabase.io/project/_/integrations/vault/overview) and add all these `Enumerated Types`:
```dart
enum user_type {
  user,
  employee,
  parkingOwner,
}
```
```dart
enum gender {
  male,
  female,
  others,
}
```
```dart
enum ticket_status {
  cancelled,
  completed,
  active,
  paid,
  created,
}
```
```dart
enum shift_type {
  morning,
  afternoon,
  night,
  other,
}
```
```dart
enum sort_by {
  price,
  distance,
}
```
```dart
enum sort_order {
  asc,
  desc,
}
```
- Navigate to the [Supabase SQL Editor](https://app.supabase.io/project/_/sql) and add all sql to create [EcoParking tables](https://github.com/hieutbui/database_function/tree/51b9f545f6e2c937b58ee5b90747ae115876ad83/creation)
- Navigate to the [Supabase Integration](https://supabase.com/dashboard/project/_/integrations) and enable: Cron, GraphQL and Stripe Wrapper. (Note: Some integration need a key to connect)
- Inside [Cron Jobs](https://supabase.com/dashboard/project/_/integrations/cron/jobs), link `update_ticket_status` function with schedule: `*/10 * * * *`

#### Set up env vars

Add these API keys to your Supabase Vault with the exact name:
| key                        | name                         |
| -------------------------- | ---------------------------- |
| Stripe secret API key      | ecoparking_stripe_api_key_id |
| Google cloud Web Client ID | google_signin_web_client_id  |

#### Supabase functions

- Navigate to the [Supabase SQL Editor](https://app.supabase.io/project/_/sql) and add all these function: [EcoParking Supabase funtions](https://github.com/hieutbui/database_function/tree/51b9f545f6e2c937b58ee5b90747ae115876ad83/functions)

### Mapbox
- Create your Mapbox map tiles and store the CARTO integration URL

### Build the app

#### In case you run this project locally in debug mode:
- Create `.env` file in the main project's directory
- Add all these envs:
```dotenv
MAPBOX_URL_TEMPLATE=
SUPABASE_PROJECT_URL=
SUPABASE_ANON_KEY=
STRIPE_PUBLISHABLE_KEY=
STRIPE_SECRET_KEY=
```
- Navigate to the [Supabase URL Configuration](https://supabase.com/dashboard/project/_/auth/url-configuration) and the local url that you want to run to the Redirect URLs. Ex. `http://localhost:3000`

#### In case you run this project locally in release mode:
- Web version
```bash
flutter build web --release --dart-define=STRIPE_PUBLISHABLE_KEY='' --dart-define=IS_RELEASE=TRUE --dart-define=RELEASE_TAG='' --dart-define=MAPBOX_URL_TEMPLATE='' --dart-define=SUPABASE_PROJECT_URL='' --dart-define=SUPABASE_ANON_KEY='' 
```
- Build APK
```bash
flutter build apk --release --dart-define=STRIPE_PUBLISHABLE_KEY='' --dart-define=MAPBOX_URL_TEMPLATE='' --dart-define=SUPABASE_PROJECT_URL='' --dart-define=SUPABASE_ANON_KEY=''
```
- Navigate to the [Supabase URL Configuration](https://supabase.com/dashboard/project/_/auth/url-configuration) and the local url that you want to run to the Redirect URLs. Ex. `http://localhost:3000`

#### Other environment

Please make sure your running system environment has all of these value:
| environment            | description                         |
| ---------------------- | ----------------------------------- |
| MAPBOX_URL_TEMPLATE    | *Your Mapbox CARTO integration URL* |
| SUPABASE_PROJECT_URL   | *Your Supabase project's URL*       |
| SUPABASE_ANON_KEY      | *Your Supabase project's annon key* |
| STRIPE_PUBLISHABLE_KEY | *Your Stripe's publishable key*     |
| STRIPE_SECRET_KEY      | *Your Strips's secret key*          |

*For OAuth Signin, please add the URL to the Supabase Site URL and Supabase Redirect URLs*