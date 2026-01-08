import 'package:flutter/material.dart';

class DoctorDashboardScreen extends StatefulWidget {
  const DoctorDashboardScreen({super.key});

  @override
  State<DoctorDashboardScreen> createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> {
  bool _showDailyEarnings = true; // Toggle between daily and monthly

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildAppBar(),
            SliverToBoxAdapter(child: _buildStatisticsGrid()),
            SliverToBoxAdapter(child: _buildEarningsSummary()),
            SliverToBoxAdapter(child: const SizedBox(height: 20)),
            SliverToBoxAdapter(child: _buildQuickActions()),
            SliverToBoxAdapter(child: _buildNotifications()),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1C2B8F),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  'New Appointment',
                  Icons.add_circle,
                  const LinearGradient(
                    colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                  ),
                  const Color(0xFF4CAF50),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  'Start Consultation',
                  Icons.video_call,
                  const LinearGradient(
                    colors: [Color(0xFF2196F3), Color(0xFF42A5F5)],
                  ),
                  const Color(0xFF2196F3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  'View Schedule',
                  Icons.calendar_month,
                  const LinearGradient(
                    colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
                  ),
                  const Color(0xFFFF9800),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  'Patient Records',
                  Icons.folder_open,
                  const LinearGradient(
                    colors: [Color(0xFF9C27B0), Color(0xFFAB47BC)],
                  ),
                  const Color(0xFF9C27B0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      String label, IconData icon, Gradient gradient, Color color) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              children: [
                Icon(icon, color: Colors.white, size: 32),
                const SizedBox(height: 8),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 140,
      floating: false,
      pinned: true,
      backgroundColor: const Color(0xFF1C2B8F),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1C2B8F),
                Color(0xFF2536B5),
                Color(0xFF2E42C9)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withValues(alpha: 0.25),
                                  Colors.white.withValues(alpha: 0.15),
                                ],
                              ),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                                width: 2,
                              ),
                            ),
                            child: const Icon(Icons.person,
                                color: Colors.white, size: 30),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome Back! 👋',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.85),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Dr. Smith',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.notifications_outlined),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFF5252),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticsGrid() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Today\'s Overview',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1C2B8F),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.schedule, color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.35,
            children: [
              _buildStatCard(
                title: 'Today Appointments',
                value: '12',
                icon: Icons.calendar_today,
                color: const Color(0xFF4CAF50),
                gradient: const LinearGradient(
                  colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                trend: '+3',
              ),
              _buildStatCard(
                title: 'Upcoming Consultations',
                value: '8',
                icon: Icons.video_call,
                color: const Color(0xFF2196F3),
                gradient: const LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFF42A5F5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                trend: '+2',
              ),
              _buildStatCard(
                title: 'Pending Requests',
                value: '5',
                icon: Icons.pending_actions,
                color: const Color(0xFFFF9800),
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                trend: '-1',
              ),
              _buildStatCard(
                title: 'Total Patients',
                value: '342',
                icon: Icons.people,
                color: const Color(0xFF9C27B0),
                gradient: const LinearGradient(
                  colors: [Color(0xFF9C27B0), Color(0xFFAB47BC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                trend: '+12',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required Gradient gradient,
    String? trend,
  }) {
    final isPositive = trend != null && trend.startsWith('+');
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleStatCardTap(title),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: Colors.white, size: 24),
                    ),
                    if (trend != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isPositive
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              color: Colors.white,
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              trend,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.95),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEarningsSummary() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.white, Color(0xFFFAFBFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1C2B8F).withValues(alpha: 0.1),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Earnings Summary',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1C2B8F),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F7FB),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFF1C2B8F).withValues(alpha: 0.1),
                      ),
                    ),
                    child: Row(
                      children: [
                        _buildToggleButton('Daily', _showDailyEarnings),
                        _buildToggleButton('Monthly', !_showDailyEarnings),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF4CAF50).withValues(alpha: 0.1),
                      const Color(0xFF66BB6A).withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _showDailyEarnings
                                ? 'Today\'s Earnings'
                                : 'This Month',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _showDailyEarnings ? '₹12,450' : '₹2,45,800',
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF4CAF50),
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50)
                                  .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.trending_up,
                                    color: Color(0xFF4CAF50), size: 14),
                                SizedBox(width: 4),
                                Text(
                                  '+15% from last week',
                                  style: TextStyle(
                                    color: Color(0xFF4CAF50),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color:
                                const Color(0xFF4CAF50).withValues(alpha: 0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.attach_money,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 16),
              _buildEarningsDetail(
                'Consultations',
                _showDailyEarnings ? '₹8,500' : '₹1,68,000',
                Icons.video_call,
                const Color(0xFF2196F3),
              ),
              const SizedBox(height: 14),
              _buildEarningsDetail(
                'Physical Appointments',
                _showDailyEarnings ? '₹3,950' : '₹77,800',
                Icons.local_hospital,
                const Color(0xFF4CAF50),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showDailyEarnings = text == 'Daily';
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1C2B8F) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade600,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildEarningsDetail(
      String title, String amount, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1C2B8F),
          ),
        ),
      ],
    );
  }

  Widget _buildNotifications() {
    final notifications = [
      {
        'title': 'New Appointment Request',
        'message': 'Mr. Rajesh Kumar requested appointment for tomorrow',
        'time': '5 min ago',
        'icon': Icons.calendar_today,
        'color': const Color(0xFF4CAF50),
        'unread': true,
      },
      {
        'title': 'Consultation Reminder',
        'message': 'Video consultation with Mrs. Sharma in 30 minutes',
        'time': '25 min ago',
        'icon': Icons.video_call,
        'color': const Color(0xFF2196F3),
        'unread': true,
      },
      {
        'title': 'Payment Received',
        'message': 'Payment of ₹1,200 received for consultation',
        'time': '1 hour ago',
        'icon': Icons.payment,
        'color': const Color(0xFF4CAF50),
        'unread': false,
      },
      {
        'title': 'New Review',
        'message': 'Mr. Patel left a 5-star review for your service',
        'time': '2 hours ago',
        'icon': Icons.star,
        'color': const Color(0xFFFF9800),
        'unread': false,
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1C2B8F), Color(0xFF2536B5)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.notifications_active,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1C2B8F),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF5252), Color(0xFFFF6E6E)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF5252).withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Text(
                      '2 New',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: notifications.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: Colors.grey.shade200,
              ),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _buildNotificationItem(
                  title: notification['title'] as String,
                  message: notification['message'] as String,
                  time: notification['time'] as String,
                  icon: notification['icon'] as IconData,
                  color: notification['color'] as Color,
                  unread: notification['unread'] as bool,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF1C2B8F).withValues(alpha: 0.2),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: () => _viewAllNotifications(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View All Notifications',
                          style: TextStyle(
                            color: Color(0xFF1C2B8F),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF1C2B8F),
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String message,
    required String time,
    required IconData icon,
    required Color color,
    required bool unread,
  }) {
    return Container(
      color: unread
          ? color.withValues(alpha: 0.03)
          : Colors.white,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleNotificationTap(title),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color,
                        color.withValues(
                            red: (color.r * 1.1).clamp(0, 1),
                            green: (color.g * 1.1).clamp(0, 1),
                            blue: (color.b * 1.1).clamp(0, 1)),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(icon, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight:
                                    unread ? FontWeight.w700 : FontWeight.w600,
                                color: const Color(0xFF1C2B8F),
                              ),
                            ),
                          ),
                          if (unread)
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFF5252),
                                    Color(0xFFFF6E6E)
                                  ],
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFF5252)
                                        .withValues(alpha: 0.5),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.access_time,
                              size: 12, color: Colors.grey.shade500),
                          const SizedBox(width: 4),
                          Text(
                            time,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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

  void _handleStatCardTap(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening $title details...'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleNotificationTap(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening notification: $title'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _viewAllNotifications() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening all notifications...'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
