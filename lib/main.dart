import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/login_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/app_onboarding_screen.dart';
import 'screens/user_type_selection.dart';

void main() => runApp(const SignUpProtoApp());

class SignUpProtoApp extends StatelessWidget {
  const SignUpProtoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Sign Up Prototype',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.interTextTheme(base),
      ),
      home: const AppEntry(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppEntry extends StatefulWidget {
  const AppEntry({super.key});

  @override
  State<AppEntry> createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {
  bool _onboardingDone = false;

  @override
  Widget build(BuildContext context) {
    if (_onboardingDone) return const AuthGateway();
    return AppOnboardingScreen(onFinished: () {
      setState(() => _onboardingDone = true);
    });
  }
}

class AuthGateway extends StatefulWidget {
  const AuthGateway({super.key});

  @override
  State<AuthGateway> createState() => _AuthGatewayState();
}

class _AuthGatewayState extends State<AuthGateway> {
  bool _isSignUp = true;
  String? _userType; // 'patient' or 'doctor'

  @override
  Widget build(BuildContext context) {
    if (_userType == null) {
      return UserTypeSelection(
        onSelected: (type) => setState(() => _userType = type),
      );
    }
    return _isSignUp
        ? SignUpScreen(
            onSwitchToLogin: () => setState(() => _isSignUp = false),
            initialUserType: _userType,
          )
        : LoginScreen(
            onSwitchToSignUp: () => setState(() => _isSignUp = true),
          );
  }
}
