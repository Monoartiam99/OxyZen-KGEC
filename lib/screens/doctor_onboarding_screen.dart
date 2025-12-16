import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoctorOnboardingScreen extends StatefulWidget {
  final bool fromLogin;

  const DoctorOnboardingScreen({super.key, this.fromLogin = false});

  @override
  State<DoctorOnboardingScreen> createState() => _DoctorOnboardingScreenState();
}

class _QualificationEntry {
  _QualificationEntry()
      : degreeCtrl = TextEditingController(),
        institutionCtrl = TextEditingController(),
        certificateUploaded = false,
        verificationSourceCtrl = TextEditingController();

  final TextEditingController degreeCtrl;
  final TextEditingController institutionCtrl;
  final TextEditingController verificationSourceCtrl;
  bool certificateUploaded;

  void dispose() {
    degreeCtrl.dispose();
    institutionCtrl.dispose();
    verificationSourceCtrl.dispose();
  }
}

class _DoctorOnboardingScreenState extends State<DoctorOnboardingScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _pageController = PageController();
  final _forms = List.generate(6, (_) => GlobalKey<FormState>());
  int _step = 0;

  // Simple doctor login
  final _appIdCtrl = TextEditingController();
  final _appPasswordCtrl = TextEditingController();
  bool _obscureAppPassword = true;
  bool _appLoginLoading = false;

  // Page 1
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  // Page 2
  final _fullNameCtrl = TextEditingController();
  final _contactCtrl = TextEditingController();
  final _dobCtrl = TextEditingController();
  final _regNoCtrl = TextEditingController();
  final _regYearCtrl = TextEditingController();

  // Page 3
  final List<_QualificationEntry> _qualifications = [
    _QualificationEntry(),
    _QualificationEntry()
  ];

  // Page 4
  bool _idProofUploaded = false;
  bool _photoUploaded = false;
  bool _signatureUploaded = false;

  // Page 5
  final List<String> _allSpecialities = const [
    'Cardiology',
    'Dermatology',
    'ENT',
    'General Medicine',
    'Neurology',
    'Orthopedics',
    'Pediatrics',
    'Psychiatry',
    'Radiology',
    'Surgery',
    'Urology',
  ];
  final Set<String> _selectedSpecialities = {};
  double _experienceYears = 0;

  // Page 6
  bool _termsAccepted = false;
  bool _submitting = false;

  @override
  void dispose() {
    _pageController.dispose();
    _appIdCtrl.dispose();
    _appPasswordCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _fullNameCtrl.dispose();
    _contactCtrl.dispose();
    _dobCtrl.dispose();
    _regNoCtrl.dispose();
    _regYearCtrl.dispose();
    for (final q in _qualifications) {
      q.dispose();
    }
    super.dispose();
  }

  InputDecoration _inputDecoration(String hint, {IconData? icon}) =>
      InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF8FFFE),
        prefixIcon: icon != null
            ? Icon(icon, color: const Color(0xFF2E8B22), size: 22)
            : null,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF2E8B22), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      );

  Future<void> _next() async {
    if (!_validateStep()) return;
    if (_step >= 5) {
      await _submit();
      return;
    }
    setState(() => _step += 1);
    _pageController.animateToPage(_step,
        duration: const Duration(milliseconds: 280), curve: Curves.easeInOut);
  }

  void _back() {
    if (_step == 0) return;
    setState(() => _step -= 1);
    _pageController.animateToPage(_step,
        duration: const Duration(milliseconds: 240), curve: Curves.easeOut);
  }

  bool _validateStep() {
    final form = _forms[_step].currentState;
    if (form != null && !form.validate()) {
      return false;
    }
    if (_step == 2) {
      final first = _qualifications.first;
      if (first.degreeCtrl.text.trim().isEmpty ||
          first.institutionCtrl.text.trim().isEmpty ||
          !first.certificateUploaded) {
        _showToast(
            'Please complete at least one qualification including certificate.');
        return false;
      }
    }
    if (_step == 3) {
      if (!_idProofUploaded || !_photoUploaded || !_signatureUploaded) {
        _showToast('Upload ID, photo, and signature to continue.');
        return false;
      }
    }
    if (_step == 4) {
      if (_selectedSpecialities.isEmpty) {
        _showToast('Select at least one speciality.');
        return false;
      }
    }
    if (_step == 5) {
      if (!_termsAccepted) {
        _showToast('Please accept terms and conditions.');
        return false;
      }
    }
    return true;
  }

  Future<void> _submit() async {
    setState(() => _submitting = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _submitting = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Doctor verification submitted (mock)')),
    );
    Navigator.of(context).pop();
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _submitDoctorLogin() async {
    final form = _loginFormKey.currentState;
    if (form == null || !form.validate()) return;
    setState(() => _appLoginLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _appLoginLoading = false);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Doctor login (mock)')));
    Navigator.of(context).pop();
  }

  Widget _buildDoctorLoginForm() {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          // App ID Field with Icon
          TextFormField(
            controller: _appIdCtrl,
            decoration: _inputDecoration('Enter your App ID',
                icon: Icons.badge_outlined),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'App ID is required' : null,
          ),
          const SizedBox(height: 16),
          // Password Field with Icon and Toggle
          TextFormField(
            controller: _appPasswordCtrl,
            obscureText: _obscureAppPassword,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            decoration: _inputDecoration('Enter your password',
                    icon: Icons.lock_outline)
                .copyWith(
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureAppPassword
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: const Color(0xFF2E8B22),
                  size: 22,
                ),
                onPressed: () =>
                    setState(() => _obscureAppPassword = !_obscureAppPassword),
              ),
            ),
            validator: (v) =>
                v == null || v.isEmpty ? 'Password is required' : null,
          ),
          const SizedBox(height: 10),
          // Forgot Password Link
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Password recovery coming soon')),
                );
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Color(0xFF2E8B22),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Modern Login Button with Gradient
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
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
                  color: const Color(0xFF2E8B22).withOpacity(0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
                BoxShadow(
                  color: const Color(0xFF2E8B22).withOpacity(0.2),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                onTap: _appLoginLoading ? null : _submitDoctorLogin,
                borderRadius: BorderRadius.circular(14),
                splashColor: Colors.white.withOpacity(0.2),
                highlightColor: Colors.white.withOpacity(0.1),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  alignment: Alignment.center,
                  child: _appLoginLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                              strokeWidth: 3, color: Colors.white),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.login_rounded,
                                color: Colors.white, size: 22),
                            SizedBox(width: 10),
                            Text(
                              'Login as Doctor',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Help Text
          Center(
            child: Text(
              'Secure access for verified medical professionals',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Step ${_step + 1} of 6',
            style: const TextStyle(fontWeight: FontWeight.w700)),
        Text(widget.fromLogin ? 'Doctor login' : 'Doctor sign up',
            style: const TextStyle(color: Colors.black54)),
      ],
    );
  }

  Widget _uploadTile(
      {required String label,
      required bool uploaded,
      required VoidCallback onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      title: Text(label),
      subtitle: Text(uploaded ? 'Uploaded' : 'Not uploaded',
          style: TextStyle(color: uploaded ? Colors.green : Colors.red)),
      trailing: OutlinedButton(
          onPressed: onTap, child: Text(uploaded ? 'Replace' : 'Upload')),
    );
  }

  Widget _buildPageOne() {
    return Form(
      key: _forms[0],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Page 1',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          TextFormField(
            controller: _phoneCtrl,
            decoration: _inputDecoration('Contact Number'),
            keyboardType: TextInputType.phone,
            validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _emailCtrl,
            decoration: _inputDecoration('Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (v) =>
                v == null || !v.contains('@') ? 'Enter valid email' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildPageTwo() {
    return Form(
      key: _forms[1],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Page 2',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          TextFormField(
            controller: _fullNameCtrl,
            decoration: _inputDecoration('Full Name'),
            validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _contactCtrl,
            decoration: _inputDecoration('Contact Mobile Number'),
            keyboardType: TextInputType.phone,
            validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _dobCtrl,
            decoration: _inputDecoration('Date of Birth (DD/MM/YYYY)'),
            validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _regNoCtrl,
            decoration: _inputDecoration('Registration Number'),
            validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _regYearCtrl,
            decoration: _inputDecoration('Year of Registration'),
            keyboardType: TextInputType.number,
            validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildQualificationCard(int index) {
    final entry = _qualifications[index];
    final label = 'Qualification ${index + 1}';
    final optional = index > 0;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$label${optional ? ' (optional)' : ''}',
                style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            TextFormField(
              controller: entry.degreeCtrl,
              decoration: _inputDecoration('Degree Name'),
              validator: (v) {
                if (optional && (v == null || v.trim().isEmpty)) return null;
                return v == null || v.trim().isEmpty ? 'Required' : null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: entry.institutionCtrl,
              decoration: _inputDecoration('Institution'),
              validator: (v) {
                if (optional && (v == null || v.trim().isEmpty)) return null;
                return v == null || v.trim().isEmpty ? 'Required' : null;
              },
            ),
            const SizedBox(height: 10),
            _uploadTile(
              label: 'Upload valid medical practitioner certificate',
              uploaded: entry.certificateUploaded,
              onTap: () => setState(() => entry.certificateUploaded = true),
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: entry.verificationSourceCtrl,
              decoration: _inputDecoration(
                  'From where OxyZen checks your qualification (optional)'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageThree() {
    return Form(
      key: _forms[2],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Page 3',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const Text("Doctor's Qualification",
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          _buildQualificationCard(0),
          _buildQualificationCard(1),
        ],
      ),
    );
  }

  Widget _buildPageFour() {
    return Form(
      key: _forms[3],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Page 4',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _uploadTile(
            label: 'Upload your valid ID proof',
            uploaded: _idProofUploaded,
            onTap: () => setState(() => _idProofUploaded = true),
          ),
          _uploadTile(
            label: 'Upload your passport size official photo',
            uploaded: _photoUploaded,
            onTap: () => setState(() => _photoUploaded = true),
          ),
          _uploadTile(
            label: 'Upload signature',
            uploaded: _signatureUploaded,
            onTap: () => setState(() => _signatureUploaded = true),
          ),
        ],
      ),
    );
  }

  Widget _buildPageFive() {
    return Form(
      key: _forms[4],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Page 5',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const Text("Doctor's Speciality / Category",
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _allSpecialities
                .map(
                  (s) => FilterChip(
                    label: Text(s),
                    selected: _selectedSpecialities.contains(s),
                    onSelected: (val) => setState(() {
                      if (val) {
                        _selectedSpecialities.add(s);
                      } else {
                        _selectedSpecialities.remove(s);
                      }
                    }),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Years of experience'),
              Text('${_experienceYears.toStringAsFixed(0)} yrs'),
            ],
          ),
          Slider(
            value: _experienceYears,
            max: 60,
            divisions: 60,
            label: _experienceYears.toStringAsFixed(0),
            onChanged: (v) => setState(() => _experienceYears = v),
          ),
        ],
      ),
    );
  }

  Widget _buildPageSix() {
    return Form(
      key: _forms[5],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Page 6',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: _termsAccepted,
            onChanged: (v) => setState(() => _termsAccepted = v ?? false),
            title: const Text('I agree to the Terms and Conditions.'),
          ),
          const SizedBox(height: 10),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Verify details'),
            subtitle: Text(
              'Ensure all details are correct before submitting. This is a mock submission for now.',
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fromLogin) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F9F7),
        appBar: AppBar(
          title: const Text(
            'Doctor Login',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          foregroundColor: const Color(0xFF1A1A1A),
          elevation: 0,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Header - Modern 3D Style with Gradient and Glow
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer glow effect
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              const Color(0xFF2E8B22).withOpacity(0.15),
                              const Color(0xFF2E8B22).withOpacity(0.05),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.6, 1.0],
                          ),
                        ),
                      ),
                      // Gradient border ring
                      Container(
                        width: 115,
                        height: 115,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF2E8B22),
                              Color(0xFF3FA832),
                              Color(0xFF52C441),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF2E8B22).withOpacity(0.4),
                              blurRadius: 24,
                              offset: const Offset(0, 10),
                              spreadRadius: 0,
                            ),
                            BoxShadow(
                              color: const Color(0xFF2E8B22).withOpacity(0.2),
                              blurRadius: 40,
                              offset: const Offset(0, 20),
                              spreadRadius: -5,
                            ),
                          ],
                        ),
                      ),
                      // Inner white container
                      Container(
                        width: 108,
                        height: 108,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      // Logo
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: SvgPicture.asset(
                            'assets/logo.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      // Glossy overlay effect
                      Positioned(
                        top: 10,
                        left: 15,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Colors.white.withOpacity(0.3),
                                Colors.white.withOpacity(0.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  // Login Card
                  Container(
                    constraints: const BoxConstraints(maxWidth: 440),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Title Section
                          Column(
                            children: [
                              const Text(
                                'Professional Access',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1A1A1A),
                                  letterSpacing: 0.3,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Enter your credentials to access the doctor portal',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          _buildDoctorLoginForm(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Additional Help Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F8F4),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF2E8B22).withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: const Color(0xFF2E8B22),
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Need access? Contact your administrator for credentials.',
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
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Verification'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: _buildStepIndicator(),
            ),
            const Divider(height: 1),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: _buildPageOne()),
                  SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: _buildPageTwo()),
                  SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: _buildPageThree()),
                  SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: _buildPageFour()),
                  SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: _buildPageFive()),
                  SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: _buildPageSix()),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, -2))
              ]),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _step == 0 ? null : _back,
                      child: const Text('Back'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submitting ? null : _next,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E8B22),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: _submitting
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2))
                          : Text(_step == 5 ? 'Submit' : 'Next',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
