# Flutter Sign-in Prototype

This is a minimal Flutter prototype reproducing a Figma sign-in screen. It's intended to be used for local prototyping on Web and mobile.

## Requirements
- Flutter installed and available on PATH (https://flutter.dev)
- An emulator or a browser for `flutter run`

## Run (PowerShell)
```powershell
cd d:/OxyZen-KGEC/Oxygen-app/flutter-signin-proto
flutter pub get
# Run in Chrome
flutter run -d chrome
# or run on an attached Android device/emulator
flutter run -d emulator-5554
```

Files of interest:
- `lib/main.dart` — sign-in UI prototype
- `pubspec.yaml` — minimal dependencies

Next steps you might want:
- Provide exact Figma assets (logo, icons, fonts) to make this pixel-perfect.
- Integrate auth: Firebase, Auth0, or your own backend.
- Add validation and error states to the form.

Tell me if you want me to wire Firebase Auth (email/password and Google) or tune the UI to match exact Figma colors and type scales.