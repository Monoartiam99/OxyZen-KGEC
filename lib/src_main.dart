import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const SignInProtoApp());
}

class SignInProtoApp extends StatelessWidget {
  const SignInProtoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTextTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Sign-in Prototype',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.interTextTheme(baseTextTheme),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const SignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  void _signIn() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() => _loading = false);
    debugPrint(
        'Sign-in with: ${_emailController.text} / ${_passwordController.text}');
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Signed in (prototype)')));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F172A), Color(0xFF071130)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.white.withValues(alpha: 0.06),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Top logo/title
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              // Placeholder logo (circle with initials)
                              Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF0B69FF),
                                    shape: BoxShape.circle),
                                alignment: Alignment.center,
                                child: const Text('OZ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                              ),
                              const SizedBox(width: 12),
                              Text('Welcome back',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          const Text('Sign in to continue',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white70)),
                        ],
                      ),

                      const SizedBox(height: 22),

                      // Form area (white card overlay)
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withValues(alpha: 0.12),
                                blurRadius: 12,
                                offset: const Offset(0, 6))
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                  hintText: 'Email or phone'),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: _passwordController,
                              obscureText: _obscure,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                suffixIcon: IconButton(
                                    icon: Icon(_obscure
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () =>
                                        setState(() => _obscure = !_obscure)),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    onPressed: () {},
                                    child: const Text('Forgot password?',
                                        style:
                                            TextStyle(color: Colors.black54)))),
                            const SizedBox(height: 6),
                            ElevatedButton(
                              onPressed: _loading ? null : _signIn,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0B69FF),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              child: _loading
                                  ? const SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: CircularProgressIndicator(
                                          color: Colors.white, strokeWidth: 2))
                                  : const Text('Sign in',
                                      style: TextStyle(fontSize: 16)),
                            ),
                            const SizedBox(height: 14),
                            Row(children: const [
                              Expanded(child: Divider()),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text('OR')),
                              Expanded(child: Divider())
                            ]),
                            const SizedBox(height: 12),
                            Row(children: [
                              Expanded(
                                  child: OutlinedButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.apple),
                                      label: const Text('Apple'))),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: OutlinedButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.g_mobiledata),
                                      label: const Text('Google'))),
                            ]),
                            const SizedBox(height: 16),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Don\'t have an account? ',
                                      style: TextStyle(color: Colors.black54)),
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text('Create account'))
                                ]),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Small footer / hint
                      Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                              'App prototype • ${size.width > 500 ? 'Desktop / Web' : 'Mobile'} view',
                              style: const TextStyle(color: Colors.white38),
                              textAlign: TextAlign.center)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
