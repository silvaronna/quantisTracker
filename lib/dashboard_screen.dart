import 'dart:ui';
import 'package:flutter/material.dart';

import 'market_screen.dart';
import 'reusable_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 48, bottom: 128),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderRow(),
                    const SizedBox(height: 32),
                    _buildMasterPortfolioCard(),
                    const SizedBox(height: 40),
                    _buildQuickActionsRow(),
                    const SizedBox(height: 16),
                    _buildAssetsSection(context),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildNavigationBar(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1C1C1E),
              ),
              clipBehavior: Clip.hardEdge,
              child: const Icon(Icons.person_outline, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.50),
                  ),
                ),
                const Text(
                  'Leon Subianto Kennedy',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: -0.2,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
        Stack(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xFF1C1C1E),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.notifications_none, color: Colors.white, size: 18),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF3B30),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMasterPortfolioCard() {
    return const GlassCard(
      useGradient: true,
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Balance',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '\$124,530.00',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: Color(0xFF05070A),
              letterSpacing: -0.5,
              height: 1.0,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _ChangeBadge(),
              SizedBox(width: 8),
              Text(
                '(\$14,200.00) Today',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsRow() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _QuickActionItem(icon: Icons.download, label: 'Deposit'),
          _QuickActionItem(icon: Icons.upload, label: 'Withdraw'),
          _QuickActionItem(icon: Icons.swap_horiz, label: 'Swap'),
          _QuickActionItem(icon: Icons.qr_code_scanner, label: 'Scanner'),
        ],
      ),
    );
  }

  Widget _buildAssetsSection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Assets',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: -0.3,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'See All',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF0ABAB5),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              _buildAssetRow(
                context,
                id: 'btc',
                name: 'Bitcoin',
                symbol: 'BTC',
                balance: '0.45 BTC',
                value: '\$28,450.00',
                change: '+4.2%',
                isUp: true,
                sparklineData: [40, 42, 39, 45, 48, 46, 52],
                iconBgColor: const Color(0xFFF7931A).withValues(alpha: 0.20),
                iconFgColor: const Color(0xFFF7931A),
                iconLetter: 'B',
                logoPath: 'assets/logos/Bitcoin-Logo.png',
                showDivider: true,
              ),
              _buildAssetRow(
                context,
                id: 'eth',
                name: 'Ethereum',
                symbol: 'ETH',
                balance: '4.2 ETH',
                value: '\$8,240.00',
                change: '+2.1%',
                isUp: true,
                sparklineData: [20, 22, 25, 23, 26, 28, 29],
                iconBgColor: const Color(0xFF627EEA).withValues(alpha: 0.20),
                iconFgColor: const Color(0xFF627EEA),
                iconLetter: 'E',
                logoPath: 'assets/logos/ETH-Logo.png',
                showDivider: true,
              ),
              _buildAssetRow(
                context,
                id: 'aapl',
                name: 'Apple Inc.',
                symbol: 'AAPL',
                balance: '50 AAPL',
                value: '\$9,500.00',
                change: '-1.5%',
                isUp: false,
                sparklineData: [80, 78, 79, 75, 72, 74, 70],
                iconBgColor: Colors.white.withValues(alpha: 0.10),
                iconFgColor: Colors.white,
                iconLetter: 'A',
                logoPath: 'assets/logos/Apple-Logo.png',
                showDivider: true,
              ),
              _buildAssetRow(
                context,
                id: 'tsla',
                name: 'Tesla',
                symbol: 'TSLA',
                balance: '15 TSLA',
                value: '\$3,100.00',
                change: '+8.4%',
                isUp: true,
                sparklineData: [30, 35, 34, 40, 45, 42, 48],
                iconBgColor: const Color(0xFFE31937).withValues(alpha: 0.20),
                iconFgColor: const Color(0xFFE31937),
                iconLetter: 'T',
                logoPath: 'assets/logos/Tesla-Logo.png',
                showDivider: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAssetRow(
    BuildContext context, {
    required String id,
    required String name,
    required String symbol,
    required String balance,
    required String value,
    required String change,
    required bool isUp,
    required List<double> sparklineData,
    required Color iconBgColor,
    required Color iconFgColor,
    required String iconLetter,
    required String logoPath,
    required bool showDivider,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MarketScreen()),
        );
      },
      child: Container(
        color: Colors.transparent, // to catch taps on the whole row
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: iconBgColor,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: logoPath.isNotEmpty
                            ? ClipOval(
                                child: Image.asset(
                                  logoPath,
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) => Text(
                                    iconLetter,
                                    style: TextStyle(
                                      color: iconFgColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              )
                            : Text(
                                iconLetter,
                                style: TextStyle(
                                  color: iconFgColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: -0.2,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            balance,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withValues(alpha: 0.50),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      MicroSparkline(data: sparklineData, isUp: isUp),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            value,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: -0.2,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            change,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: isUp ? const Color(0xFF34C759) : const Color(0xFFFF3B30),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (showDivider)
              Padding(
                padding: const EdgeInsets.only(left: 64),
                child: Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationBar(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), // Approx 40px blur
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E).withValues(alpha: 0.70),
            border: Border(
              top: BorderSide(color: Colors.white.withValues(alpha: 0.08), width: 1),
            ),
          ),
          padding: const EdgeInsets.only(top: 12, bottom: 32, left: 24, right: 24), // iOS bottom padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavBarItem(icon: Icons.home_outlined, label: 'Home', isActive: true, onTap: () {}),
              _NavBarItem(
                icon: Icons.show_chart,
                label: 'Analytics',
                isActive: false,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MarketScreen()),
                  );
                },
              ),
              _NavBarItem(icon: Icons.pie_chart_outline, label: 'Portfolio', isActive: false, onTap: () {}),
              _NavBarItem(icon: Icons.person_outline, label: 'Profile', isActive: false, onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChangeBadge extends StatelessWidget {
  const _ChangeBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Row(
        children: [
          Icon(Icons.upload, size: 12, color: Colors.black),
          SizedBox(width: 4),
          Text(
            '+24.5%',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              letterSpacing: -0.1,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickActionItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            color: Color(0xFF1C1C1E),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: const Color(0xFF0ABAB5), size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.70),
            letterSpacing: -0.1,
          ),
        ),
      ],
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? const Color(0xFF0ABAB5) : Colors.white.withValues(alpha: 0.40),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: isActive ? const Color(0xFF0ABAB5) : Colors.white.withValues(alpha: 0.40),
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
