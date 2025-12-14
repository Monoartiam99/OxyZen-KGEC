# Oxygen App (Flutter)

Oxygen is a Flutter prototype that walks patients and doctors through onboarding, sign up, and login screens. All flows are client-side only (no real authentication or file uploads yet) and meant to showcase the UI/UX.

## Prerequisites
- Flutter SDK installed and on your `PATH` (https://flutter.dev/docs/get-started/install)
- Dart SDK comes with Flutter (the project targets `sdk: ">=2.17.0 <3.0.0"`)
- A device target:
	- Android emulator or device
	- iOS simulator/device (macOS only)
	- Chrome/Safari/Edge for web builds

## Quick start
```powershell
cd d:/OxyZen-KGEC/Oxygen-app
flutter pub get
flutter run           # picks a connected device/emulator
flutter run -d chrome # run on web
```

## What you get
- Onboarding carousel introducing the Oxygen brand and value props
- Patient flows: sign up (name/phone/email/gender) and login (email/password) with mock Google/Apple CTAs
- Doctor path: six-step verification wizard (contact, personal details, qualifications, uploads, specialties, terms) with a simple doctor login option
- Shared styling using Inter via `google_fonts` and SVG logo via `flutter_svg`

## Project layout
- [lib/main.dart](lib/main.dart) — app entry, theme, and routing between onboarding/auth
- [lib/screens/app_onboarding_screen.dart](lib/screens/app_onboarding_screen.dart) — brand intro and feature cards carousel
- [lib/screens/sign_up_screen.dart](lib/screens/sign_up_screen.dart) — patient sign-up form and doctor sign-up button
- [lib/screens/login_screen.dart](lib/screens/login_screen.dart) — patient login form, doctor login button
- [lib/screens/doctor_onboarding_screen.dart](lib/screens/doctor_onboarding_screen.dart) — multi-step doctor verification wizard
- [assets/logo.svg](assets/logo.svg) and [assets/logo.png](assets/logo.png) — branding assets referenced in UI
- [pubspec.yaml](pubspec.yaml) — dependencies and asset configuration

## How to tweak or extend
- Replace placeholder flows: wire real auth (Firebase/Auth0/custom) where the mock SnackBars are shown.
- Hook up file uploads and storage for the doctor verification steps.
- Add form validation rules, error states, and networking as needed.
- Adjust theming (colors, typography, spacing) in `ThemeData` inside [lib/main.dart](lib/main.dart).

## Troubleshooting
- If no devices show up, run `flutter devices` to confirm emulators are running.
- For web builds, ensure Chrome/Edge/Safari is installed and `flutter config --enable-web` is set.
- If assets fail to load, verify the files exist under `assets/` and that `flutter pub get` has run.