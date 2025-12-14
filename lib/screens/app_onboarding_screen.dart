import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class _OnboardingCardData {
  const _OnboardingCardData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.bg,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final List<Color> bg;
}

class AppOnboardingScreen extends StatefulWidget {
  const AppOnboardingScreen({super.key, required this.onFinished});

  final VoidCallback onFinished;

  @override
  State<AppOnboardingScreen> createState() => _AppOnboardingScreenState();
}

class _AppOnboardingScreenState extends State<AppOnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  final _cards = const [
    _OnboardingCardData(
      title: 'Grow with Oxygen',
      subtitle:
          'Reach more patients, build trust, and keep your practice connected.',
      icon: Icons.health_and_safety_rounded,
      accent: Color(0xFF2E8B22),
      bg: [Color(0xFFEAF7EE), Color(0xFFD7F0DF)],
    ),
    _OnboardingCardData(
      title: 'Stay available',
      subtitle: 'Virtual consults and follow-ups when it works for you.',
      icon: Icons.chat_bubble_outline_rounded,
      accent: Color(0xFF1077C3),
      bg: [Color(0xFFE8F3FB), Color(0xFFD9ECF8)],
    ),
    _OnboardingCardData(
      title: 'Track and simplify',
      subtitle: 'Keep notes, documents, and verifications tidy in one place.',
      icon: Icons.fact_check_rounded,
      accent: Color(0xFFEA8C00),
      bg: [Color(0xFFFFF3E0), Color(0xFFFFE8CC)],
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    final total = _cards.length + 1;
    if (_page >= total - 1) {
      widget.onFinished();
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                itemCount: _cards.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                      child: _BrandIntroPage(),
                    );
                  }
                  final card = _cards[index - 1];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    child: _OnboardingCard(card: card),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            _Dots(count: _cards.length + 1, active: _page),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E8B22),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _page == 0 ? 'Get started' : 'Next',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _BrandIntroPage extends StatelessWidget {
  const _BrandIntroPage();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xF7FFFFFF),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: SvgPicture.asset(
                  'assets/logo.svg',
                  height: 78,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          const Text(
            'The best way to connect with your patients, grow your practice and enhance your professional network; anytime, anywhere :)',
            style: TextStyle(
              fontSize: 20,
              height: 1.4,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0D3751),
            ),
          ),
          const SizedBox(height: 26),
          Expanded(
            child: Center(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xDDE8F3FB),
                  borderRadius: BorderRadius.circular(18),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.handshake, size: 86, color: Color(0xFF1077C3)),
                    SizedBox(height: 12),
                    Text(
                      'Join Oxygen and stay closer to your patients.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.35,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0D3751),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingCard extends StatelessWidget {
  const _OnboardingCard({required this.card});

  final _OnboardingCardData card;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 6),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: card.bg,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Icon(card.icon, color: card.accent, size: 96),
                ),
              ),
            ),
          ),
          const SizedBox(height: 26),
          Text(
            card.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0D3751)),
          ),
          const SizedBox(height: 10),
          Text(
            card.subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 15, height: 1.4, color: Colors.black54),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.active});

  final int count;
  final int active;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final selected = i == active;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: selected ? 18 : 8,
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF2E8B22) : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}
