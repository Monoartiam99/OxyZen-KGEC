import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'doctor_onboarding_screen.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onSwitchToLogin;
  final String? initialUserType; // 'patient' or 'doctor'

  const SignUpScreen({
    super.key,
    required this.onSwitchToLogin,
    this.initialUserType,
  });

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
  String _userType = 'patient'; // 'patient' or 'doctor'

  @override
  void initState() {
    super.initState();
    if (widget.initialUserType != null) {
      _userType = widget.initialUserType!;
    }
  }

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

    // Navigate to home screen after successful sign up
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    }
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
    return Scaffold(
      backgroundColor: const Color(0xFFFAFCFB),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFAFCFB), Color(0xFFF0F8F4)],
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 85,
                    height: 85,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color:
                              const Color(0xFF2E8B22).withValues(alpha: 0.15),
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
                const SizedBox(height: 18),
                Column(
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
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => _userType = 'patient'),
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: _userType == 'patient'
                                        ? const Color(0xFF2E8B22)
                                        : Colors.grey.shade300,
                                    width: _userType == 'patient' ? 2 : 1.5,
                                  ),
                                  color: _userType == 'patient'
                                      ? const Color(0xFF2E8B22)
                                          .withValues(alpha: 0.1)
                                      : Colors.transparent,
                                ),
                                child: _userType == 'patient'
                                    ? const Center(
                                        child: Icon(
                                          Icons.check,
                                          size: 12,
                                          color: Color(0xFF2E8B22),
                                        ),
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Patient',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A1A1A),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 28),
                        GestureDetector(
                          onTap: () => setState(() => _userType = 'doctor'),
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: _userType == 'doctor'
                                        ? const Color(0xFF2E8B22)
                                        : Colors.grey.shade300,
                                    width: _userType == 'doctor' ? 2 : 1.5,
                                  ),
                                  color: _userType == 'doctor'
                                      ? const Color(0xFF2E8B22)
                                          .withValues(alpha: 0.1)
                                      : Colors.transparent,
                                ),
                                child: _userType == 'doctor'
                                    ? const Center(
                                        child: Icon(
                                          Icons.check,
                                          size: 12,
                                          color: Color(0xFF2E8B22),
                                        ),
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Doctor',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A1A1A),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _userType == 'patient'
                    ? _buildPatientForm()
                    : _buildDoctorForm(),
                const SizedBox(height: 28),
                _buildLoginPrompt(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginPrompt() {
    return Column(
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
              color: const Color(0xFF2E8B22).withValues(alpha: 0.1),
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
    );
  }

  // Patient Sign-Up Form
  Widget _buildPatientForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Full Name Field
          TextFormField(
            controller: _nameCtrl,
            decoration: _inputDecoration('Full Name'),
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'Full name required' : null,
          ),
          const SizedBox(height: 12),

          // Phone Field
          TextFormField(
            controller: _phoneCtrl,
            decoration: _inputDecoration('Phone Number'),
            keyboardType: TextInputType.phone,
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'Phone number required' : null,
          ),
          const SizedBox(height: 12),

          // Email Field
          TextFormField(
            controller: _emailCtrl,
            decoration: _inputDecoration('Email Address'),
            keyboardType: TextInputType.emailAddress,
            validator: (v) =>
                v == null || !v.contains('@') ? 'Enter valid email' : null,
          ),
          const SizedBox(height: 12),

          // Gender Dropdown
          DropdownButtonFormField<String>(
            initialValue: _gender,
            items: const [
              DropdownMenuItem(value: 'Male', child: Text('Male')),
              DropdownMenuItem(value: 'Female', child: Text('Female')),
              DropdownMenuItem(value: 'Other', child: Text('Other')),
            ],
            onChanged: (v) => setState(() => _gender = v ?? _gender),
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
          const SizedBox(height: 20),

          // Sign Up Button - Modern Gradient Style
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF2E8B22),
                  Color(0xFF3FA832),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2E8B22).withValues(alpha: 0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: const Color(0xFF2E8B22).withValues(alpha: 0.2),
                  blurRadius: 32,
                  offset: const Offset(0, 12),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                onTap: _loading ? null : _continue,
                borderRadius: BorderRadius.circular(16),
                splashColor: Colors.white.withValues(alpha: 0.2),
                highlightColor: Colors.white.withValues(alpha: 0.1),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  alignment: Alignment.center,
                  child: _loading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_add_rounded,
                              color: Colors.white,
                              size: 22,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),

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
                padding: const EdgeInsets.symmetric(horizontal: 12),
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

          // Continue with Google
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Google Sign-Up coming soon')),
                );
              },
              icon: Image.network(
                'https://www.gstatic.com/images/branding/product/1x/googleg_64dp.png',
                width: 20,
                height: 20,
                errorBuilder: (c, e, s) => const Icon(
                  Icons.account_circle,
                  size: 20,
                ),
              ),
              label: const Text(
                'Continue with Google',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
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
          const SizedBox(height: 12),

          // Continue with Apple
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Apple Sign-Up coming soon')),
                );
              },
              icon: Icon(
                Icons.apple,
                size: 20,
                color: Colors.grey.shade800,
              ),
              label: const Text(
                'Continue with Apple',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
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
        ],
      ),
    );
  }

  // Doctor Sign-Up Form
  Widget _buildDoctorForm() {
    return Column(
      children: [
        // Doctor Info
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F8F4),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF2E8B22).withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.info_outline_rounded,
                color: Color(0xFF2E8B22),
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Complete doctor verification to access professional features',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Doctor Sign Up Button
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [Color(0xFF2E8B22), Color(0xFF3FA832)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2E8B22).withValues(alpha: 0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: _doctorSignUp,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                height: 56,
                alignment: Alignment.center,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.medical_services_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Start Doctor Registration',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

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
              padding: const EdgeInsets.symmetric(horizontal: 12),
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

        // Continue with Google
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Google Sign-Up coming soon')),
              );
            },
            icon: Image.network(
              'https://www.gstatic.com/images/branding/product/1x/googleg_64dp.png',
              width: 20,
              height: 20,
              errorBuilder: (c, e, s) => const Icon(
                Icons.account_circle,
                size: 20,
              ),
            ),
            label: const Text(
              'Continue with Google',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
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
        const SizedBox(height: 12),

        // Continue with Apple
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Apple Sign-Up coming soon')),
              );
            },
            icon: Icon(
              Icons.apple,
              size: 20,
              color: Colors.grey.shade800,
            ),
            label: const Text(
              'Continue with Apple',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
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
      ],
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
