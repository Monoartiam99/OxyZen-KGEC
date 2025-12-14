import 'package:flutter/material.dart';

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
  final _pageController = PageController();
  final _forms = List.generate(6, (_) => GlobalKey<FormState>());
  int _step = 0;

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

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
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
