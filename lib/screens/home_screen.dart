import 'dart:ui';

import 'package:flutter/material.dart';
import '../models/specialty.dart';
import 'specialty_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedLocation = 'Bangalore';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static const Color _primaryGreen = Color(0xFF2E8B22);
  static const Color _secondaryGreen = Color(0xFF3FA832);
  static const Color _surfaceBg = Color(0xFFFAFCFB);
  static const Color _cardTint = Color(0xFFF0F8F4);
  static const Color _softCardTint = Color(0xFFE6F4EA);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<MedicalSpecialty> get _filteredSpecialties {
    if (_searchQuery.isEmpty) {
      return medicalSpecialties;
    }
    return medicalSpecialties.where((specialty) {
      return specialty.name
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          specialty.services.any((service) =>
              service.toLowerCase().contains(_searchQuery.toLowerCase()));
    }).toList();
  }

  Color _hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      drawer: _buildDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFe9f6ee), Color(0xFFd9efe3), Color(0xFFcde7da)],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHero(context)),
              SliverToBoxAdapter(child: _buildQuickActions()),
              SliverToBoxAdapter(child: _buildCareBanner()),
              SliverToBoxAdapter(child: _buildServicesRow()),
              SliverToBoxAdapter(child: _buildProceduresCard()),
              SliverToBoxAdapter(child: _buildAskCareCard()),
              SliverToBoxAdapter(child: const SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xE62E8B22), Color(0xD03FA832)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white.withOpacity(0.15),
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => _showLocationPicker(context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _selectedLocation,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Change location',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  ],
                ),
                IconButton(
                  onPressed: () => _showNotifications(context),
                  icon: Stack(
                    children: [
                      const Icon(Icons.notifications_none, color: Colors.white),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.35)),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: InputDecoration(
                  hintText: 'Search for symptoms, doctors, clinics...',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  prefixIcon: const Icon(Icons.search, color: Colors.black54),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          }),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    final items = [
      {
        'title': 'Physical Appointment',
        'subtitle': 'At Hospital',
        'icon': Icons.meeting_room,
        'color': _primaryGreen,
      },
      {
        'title': 'Instant Video Consult',
        'subtitle': 'Connect in 5 sec',
        'icon': Icons.video_call,
        'color': _secondaryGreen,
      },
      {
        'title': 'Medicines',
        'subtitle': 'Doorstep delivery',
        'icon': Icons.local_pharmacy,
        'color': Color(0xFF4CAF50),
      },
      {
        'title': 'Lab Tests',
        'subtitle': 'Home sample pickup',
        'icon': Icons.biotech,
        'color': Color(0xFF66BB6A),
      },
      {
        'title': 'Surgeries',
        'subtitle': 'Top surgeons',
        'icon': Icons.medical_services,
        'color': Color(0xFF81C784),
      },
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: items
            .map(
              (item) => _quickCard(
                title: item['title'] as String,
                subtitle: item['subtitle'] as String,
                icon: item['icon'] as IconData,
                color: item['color'] as Color,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _quickCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    final cardWidth = (MediaQuery.of(context).size.width - 16 * 2 - 12) / 2;
    return SizedBox(
      width: cardWidth,
      child: InkWell(
        onTap: () => _handleQuickAction(title),
        borderRadius: BorderRadius.circular(18),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.72),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white.withOpacity(0.35)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.14),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: color, size: 22),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCareBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.35)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(Icons.favorite, color: _primaryGreen),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Care Plan',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _primaryGreen,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '12 FREE Appointments for a Year',
                    style: TextStyle(fontSize: 13, color: _primaryGreen),
                  ),
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: _primaryGreen,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Care Plan feature coming soon!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('View'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesRow() {
    final chips = [
      {
        'label': 'Ask Free Question',
        'icon': Icons.chat_outlined,
      },
      {
        'label': 'Appointments',
        'icon': Icons.event_available,
      },
      {
        'label': 'Consultations',
        'icon': Icons.forum_outlined,
      },
      {
        'label': 'Medical Records',
        'icon': Icons.folder_shared,
      },
      {
        'label': 'Payments',
        'icon': Icons.account_balance_wallet_outlined,
      },
    ];

    return SizedBox(
      height: 46,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = chips[index];
          return InkWell(
            onTap: () => _handleServiceChip(item['label'] as String),
            child: Chip(
              backgroundColor: Colors.white.withOpacity(0.72),
              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
              avatar: Icon(item['icon'] as IconData,
                  size: 18, color: _primaryGreen),
              label: Text(
                item['label'] as String,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: chips.length,
      ),
    );
  }

  Widget _buildProceduresCard() {
    final procedures = ['Piles', 'Pregnancy', 'Knee Replacement', 'more'];
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.7),
          border: Border.all(color: Colors.white.withOpacity(0.35)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Affordable procedures by expert doctors',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: _primaryGreen,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: procedures
                  .map(
                    (p) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        p,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: _primaryGreen,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cost estimation feature coming soon!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: const Text('Get Cost Estimate'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAskCareCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2E8B22), Color(0xCC3FA832)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white,
              child: Icon(Icons.support_agent, color: _primaryGreen),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Ask Care AI',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '20,000+ health queries resolved',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ask Care AI feature coming soon!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialtyCard(MedicalSpecialty specialty) {
    final bgColor = _hexToColor(specialty.color);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SpecialtyDetailScreen(specialty: specialty),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    specialty.icon,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Title
              Text(
                specialty.name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              // Services
              ...specialty.services.take(2).map(
                    (service) => Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade600,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              service,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade600,
                                height: 1.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              if (specialty.services.length > 2)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    '+${specialty.services.length - 2} more',
                    style: TextStyle(
                      fontSize: 11,
                      color: _primaryGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  SliverGrid _buildSpecialtyGrid() {
    if (_filteredSpecialties.isEmpty) {
      return SliverGrid(
        // Empty grid with single item to keep layout consistent
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 2.2,
        ),
        delegate: SliverChildListDelegate([
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
                const SizedBox(height: 8),
                Text(
                  'No specialties found',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ]),
      );
    }

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.82,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => _buildSpecialtyCard(_filteredSpecialties[index]),
        childCount: _filteredSpecialties.length,
      ),
    );
  }

  // Helper methods for interactive features
  void _showLocationPicker(BuildContext context) {
    final cities = [
      'Bangalore',
      'Mumbai',
      'Delhi',
      'Kolkata',
      'Chennai',
      'Hyderabad',
      'Pune',
      'Ahmedabad'
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Location',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...cities.map(
              (city) => ListTile(
                leading: Icon(
                  Icons.location_on,
                  color:
                      city == _selectedLocation ? _primaryGreen : Colors.grey,
                ),
                title: Text(city),
                trailing: city == _selectedLocation
                    ? const Icon(Icons.check, color: _primaryGreen)
                    : null,
                onTap: () {
                  setState(() {
                    _selectedLocation = city;
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Location changed to $city'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Clear all'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _notificationTile(
              'Appointment Reminder',
              'Your appointment with Dr. Smith is tomorrow at 10 AM',
              Icons.event,
              _primaryGreen,
            ),
            _notificationTile(
              'Health Tip',
              'Remember to drink 8 glasses of water daily',
              Icons.lightbulb,
              _secondaryGreen,
            ),
            _notificationTile(
              'Lab Results Ready',
              'Your test results are now available',
              Icons.biotech,
              const Color(0xFF66BB6A),
            ),
          ],
        ),
      ),
    );
  }

  Widget _notificationTile(
      String title, String subtitle, IconData icon, Color color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 13)),
      isThreeLine: true,
    );
  }

  void _handleQuickAction(String title) {
    String message;
    switch (title) {
      case 'Physical Appointment':
        message = 'Opening physical appointment booking...';
        break;
      case 'Instant Video Consult':
        message = 'Connecting to video consultation...';
        break;
      case 'Medicines':
        message = 'Opening medicine store...';
        break;
      case 'Lab Tests':
        message = 'Opening lab test booking...';
        break;
      case 'Surgeries':
        message = 'Opening surgery consultation...';
        break;
      default:
        message = 'Feature coming soon!';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  void _handleServiceChip(String service) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening $service...'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [_primaryGreen, _secondaryGreen],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: _primaryGreen),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Welcome!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _selectedLocation,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _drawerTile(Icons.medical_services, 'ABHA', () {}),
          _drawerTile(Icons.event_available, 'Appointments', () {}),
          _drawerTile(Icons.biotech, 'Test Bookings', () {}),
          _drawerTile(Icons.shopping_bag, 'Orders', () {}),
          _drawerTile(Icons.chat, 'Consultations', () {}),
          _drawerTile(Icons.local_hospital, 'My Doctors', () {}),
          _drawerTile(Icons.folder_shared, 'Medical Records', () {}),
          _drawerTile(Icons.shield, 'My Insurance Policy', () {}),
          _drawerTile(Icons.alarm, 'Reminders', () {}),
          _drawerTile(Icons.payment, 'Payments & HealthCash', () {}),
          const Divider(),
          _drawerTile(Icons.settings, 'Settings', () {}),
          _drawerTile(Icons.help, 'Help & Support', () {}),
          _drawerTile(Icons.logout, 'Logout', () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Logout feature coming soon!'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _drawerTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: _primaryGreen),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.pop(context);
        onTap();
        if (title != 'Logout' &&
            title != 'Settings' &&
            title != 'Help & Support') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title feature coming soon!'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );
  }
}
