import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'doctor_onboarding_screen.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onSwitchToLogin;

  const SignUpScreen({super.key, required this.onSwitchToLogin});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  String _gender = 'Male';
  bool _loading = false;

  void _doctorSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const DoctorOnboardingScreen(fromLogin: false),
      ),
    );
  }

  Future<void> _continue() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 900));
    setState(() => _loading = false);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Continue (mock)')));
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF0F8F4),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2E8B22), width: 2),
        ),
        hintStyle: const TextStyle(color: Color(0xFF999999)),
      );

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFFAFCFB),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            height: screenHeight -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFAFCFB), Color(0xFFF0F8F4)],
              ),
            ),
            child: Column(
              children: [
                // Header with Logo
                Flexible(
                  flex: 1,
                  child: Center(
                    child: Container(
                      width: 85,
                      height: 85,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2E8B22).withOpacity(0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: SvgPicture.asset(
                          'assets/logo.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),

                // Welcome Text
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1A1A1A),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Join us for better health management',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Form Section
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Full Name Field
                            TextFormField(
                              controller: _nameCtrl,
                              decoration: _inputDecoration('Full Name'),
                              validator: (v) => v == null || v.trim().isEmpty
                                  ? 'Full name required'
                                  : null,
                            ),
                            const SizedBox(height: 12),

                            // Phone Field
                            TextFormField(
                              controller: _phoneCtrl,
                              decoration: _inputDecoration('Phone Number'),
                              keyboardType: TextInputType.phone,
                              validator: (v) => v == null || v.trim().isEmpty
                                  ? 'Phone number required'
                                  : null,
                            ),
                            const SizedBox(height: 12),

                            // Email Field
                            TextFormField(
                              controller: _emailCtrl,
                              decoration: _inputDecoration('Email Address'),
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) => v == null || !v.contains('@')
                                  ? 'Enter valid email'
                                  : null,
                            ),
                            const SizedBox(height: 12),

                            // Gender Dropdown
                            DropdownButtonFormField<String>(
                              value: _gender,
                              items: const [
                                DropdownMenuItem(
                                  value: 'Male',
                                  child: Text('Male'),
                                ),
                                DropdownMenuItem(
                                  value: 'Female',
                                  child: Text('Female'),
                                ),
                              ],
                              onChanged: (v) =>
                                  setState(() => _gender = v ?? _gender),
                              decoration: InputDecoration(
                                hintText: 'Select Gender',
                                filled: true,
                                fillColor: const Color(0xFFF0F8F4),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E0E0),
                                    width: 1.5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E0E0),
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF2E8B22),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),

                            // Continue Button
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF2E8B22)
                                        .withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: _loading ? null : _continue,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2E8B22),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: _loading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.5,
                                          ),
                                        )
                                      : const Text(
                                          'Continue',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Doctor Sign Up Button
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: OutlinedButton(
                                onPressed: _doctorSignUp,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF2E8B22),
                                  side: const BorderSide(
                                    color: Color(0xFF2E8B22),
                                    width: 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Doctor Sign Up',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),

                            // OR Divider
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Text(
                                    'or',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),

                            // Google Button
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: Image.network(
                                  'https://www.gstatic.com/images/branding/product/1x/googleg_64dp.png',
                                  width: 18,
                                  height: 18,
                                  errorBuilder: (c, e, s) => const Icon(
                                    Icons.account_circle,
                                    size: 18,
                                  ),
                                ),
                                label: const Text(
                                  'Continue with Google',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF2F2F2),
                                  side: const BorderSide(
                                    color: Color(0xFFE0E0E0),
                                    width: 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Apple Button
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.apple,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                label: const Text(
                                  'Continue with Apple',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  side: const BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Footer Section
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: widget.onSwitchToLogin,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2E8B22).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Login Now',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF2E8B22),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }
}
