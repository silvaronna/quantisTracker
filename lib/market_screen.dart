import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class MarketAsset {
  final String id;
  final String name;
  final String symbol;
  final String balance;
  final String value;
  final String changeText;
  final bool isUp;
  final List<FlSpot> chartData;
  final Color iconBgColor;
  final Color iconFgColor;
  final String logoPath;

  // Analytics specific data
  final String avgBuyPrice;
  final String roi;
  final String volatility;
  final String allocation;

  MarketAsset({
    required this.id,
    required this.name,
    required this.symbol,
    required this.balance,
    required this.value,
    required this.changeText,
    required this.isUp,
    required this.chartData,
    required this.iconBgColor,
    required this.iconFgColor,
    required this.logoPath,
    required this.avgBuyPrice,
    required this.roi,
    required this.volatility,
    required this.allocation,
  });
}

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final List<MarketAsset> assets = [
    MarketAsset(
      id: 'btc',
      name: 'Bitcoin',
      symbol: 'BTC',
      balance: '0.45 BTC',
      value: '\$45,800.00',
      changeText: '+\$3,540.00 (8.4%)',
      isUp: true,
      avgBuyPrice: '\$41,200.50',
      roi: '+11.16%',
      volatility: 'Medium',
      allocation: '34.5%',
      iconBgColor: const Color(0xFFF7931A).withValues(alpha: 0.20),
      iconFgColor: const Color(0xFFF7931A),
      logoPath: 'assets/logos/Bitcoin-Logo.png',
      chartData: [
        const FlSpot(0, 42000),
        const FlSpot(1, 42500),
        const FlSpot(2, 41800),
        const FlSpot(3, 43200),
        const FlSpot(4, 43100),
        const FlSpot(5, 44500),
        const FlSpot(6, 44200),
        const FlSpot(7, 45800),
      ],
    ),
    MarketAsset(
      id: 'eth',
      name: 'Ethereum',
      symbol: 'ETH',
      balance: '4.2 ETH',
      value: '\$8,240.00',
      changeText: '+\$170.00 (2.1%)',
      isUp: true,
      avgBuyPrice: '\$2,100.20',
      roi: '+8.45%',
      volatility: 'High',
      allocation: '22.1%',
      iconBgColor: const Color(0xFF627EEA).withValues(alpha: 0.20),
      iconFgColor: const Color(0xFF627EEA),
      logoPath: 'assets/logos/ETH-Logo.png',
      chartData: [
        const FlSpot(0, 8000),
        const FlSpot(1, 8100),
        const FlSpot(2, 8050),
        const FlSpot(3, 8150),
        const FlSpot(4, 8200),
        const FlSpot(5, 8180),
        const FlSpot(6, 8220),
        const FlSpot(7, 8240),
      ],
    ),
    MarketAsset(
      id: 'aapl',
      name: 'Apple Inc.',
      symbol: 'AAPL',
      balance: '50 AAPL',
      value: '\$9,500.00',
      changeText: '-\$144.40 (1.5%)',
      isUp: false,
      avgBuyPrice: '\$150.00',
      roi: '+23.94%',
      volatility: 'Low',
      allocation: '12.4%',
      iconBgColor: Colors.white.withValues(alpha: 0.10),
      iconFgColor: Colors.white,
      logoPath: 'assets/logos/Apple-Logo.png',
      chartData: [
        const FlSpot(0, 9600),
        const FlSpot(1, 9580),
        const FlSpot(2, 9550),
        const FlSpot(3, 9620),
        const FlSpot(4, 9500),
        const FlSpot(5, 9480),
        const FlSpot(6, 9490),
        const FlSpot(7, 9500),
      ],
    ),
    MarketAsset(
      id: 'tsla',
      name: 'Tesla',
      symbol: 'TSLA',
      balance: '15 TSLA',
      value: '\$3,100.00',
      changeText: '+\$260.40 (8.4%)',
      isUp: true,
      avgBuyPrice: '\$185.20',
      roi: '+11.50%',
      volatility: 'High',
      allocation: '8.6%',
      iconBgColor: const Color(0xFFE31937).withValues(alpha: 0.20),
      iconFgColor: const Color(0xFFE31937),
      logoPath: 'assets/logos/Tesla-Logo.png',
      chartData: [
        const FlSpot(0, 2800),
        const FlSpot(1, 2850),
        const FlSpot(2, 2820),
        const FlSpot(3, 2900),
        const FlSpot(4, 2950),
        const FlSpot(5, 3050),
        const FlSpot(6, 3080),
        const FlSpot(7, 3100),
      ],
    ),
  ];

  late MarketAsset selectedAsset;
  String activeInterval = '1D';
  String activeFilter = 'Crypto';

  @override
  void initState() {
    super.initState();
    selectedAsset = assets[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // Main Scrollable Content
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Top spacing for the sticky header
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
                
                SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 430),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPriceHeader(),
                          _buildChartPanel(),
                          _buildSegmentedControl(),
                          const SizedBox(height: 24),
                          _buildFilterChips(),
                          _buildAdvancedMetricsGrid(),
                          const SizedBox(height: 128), // Bottom padding
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Sticky Header (Absolutely Positioned)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 430),
                  child: _buildStickyHeader(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStickyHeader() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          color: Colors.black.withValues(alpha: 0.80),
          padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left - Back Nav
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  child: const Icon(Icons.arrow_back, color: Color(0xFF0ABAB5), size: 24),
                ),
              ),
              // Center - Asset Selector
              GestureDetector(
                onTap: _showAssetBottomSheet,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      selectedAsset.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${selectedAsset.symbol})',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.50),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_down, color: Colors.white.withValues(alpha: 0.50), size: 16),
                  ],
                ),
              ),
              // Right - Spacer
              const SizedBox(width: 40, height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _showAssetBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1C1C1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 24),
          itemCount: assets.length,
          itemBuilder: (context, index) {
            final asset = assets[index];
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: asset.iconBgColor, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: asset.logoPath.isNotEmpty
                    ? ClipOval(
                        child: Image.asset(
                          asset.logoPath,
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Text(
                            asset.symbol[0],
                            style: TextStyle(color: asset.iconFgColor, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : Text(
                        asset.symbol[0],
                        style: TextStyle(color: asset.iconFgColor, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
              ),
              title: Text(asset.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              subtitle: Text(asset.symbol, style: TextStyle(color: Colors.white.withValues(alpha: 0.5))),
              onTap: () {
                setState(() {
                  selectedAsset = asset;
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildPriceHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            selectedAsset.value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                selectedAsset.changeText,
                style: TextStyle(
                  color: selectedAsset.isUp ? const Color(0xFF34C759) : const Color(0xFFFF3B30),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.1,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Today',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.40),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartPanel() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 240,
      width: double.infinity,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineTouchData: LineTouchData(
            handleBuiltInTouches: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (touchedSpot) => const Color(0xFF1C1C1E),
              tooltipPadding: const EdgeInsets.all(8),
              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                return touchedBarSpots.map((barSpot) {
                  return LineTooltipItem(
                    '\$${barSpot.y.toStringAsFixed(0)}',
                    const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                  );
                }).toList();
              },
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: selectedAsset.chartData,
              isCurved: true,
              curveSmoothness: 0.35, // Monotone curve equivalent
              color: const Color(0xFF0ABAB5),
              barWidth: 2.5,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF0ABAB5).withValues(alpha: 0.20),
                    const Color(0xFF0ABAB5).withValues(alpha: 0.00),
                  ],
                  begin: const Alignment(0, -1),
                  end: const Alignment(0, 1),
                  stops: const [0.05, 0.95],
                ),
              ),
            ),
          ],
          minY: selectedAsset.chartData.map((e) => e.y).reduce((a, b) => a < b ? a : b) - 1000,
          maxY: selectedAsset.chartData.map((e) => e.y).reduce((a, b) => a > b ? a : b) + 1000,
        ),
        duration: const Duration(milliseconds: 150),
      ),
    );
  }

  Widget _buildSegmentedControl() {
    final intervals = ['1D', '1W', '1M', '1Y', 'ALL'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          children: intervals.map((interval) {
            final isActive = activeInterval == interval;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => activeInterval = interval),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFF636366) : Colors.transparent,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: isActive
                        ? [BoxShadow(color: Colors.black.withValues(alpha: 0.10), blurRadius: 3, offset: const Offset(0, 1))]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    interval,
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.60),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ['Crypto', 'US Stocks', 'Forex', 'ETFs', 'Commodities'];
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: filters.map((filter) {
            final isActive = activeFilter == filter;
            return GestureDetector(
              onTap: () => setState(() => activeFilter = filter),
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: isActive ? Colors.white : const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isActive ? Colors.black : Colors.white.withValues(alpha: 0.80),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildAdvancedMetricsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildMetricCard('Avg Buy Price', selectedAsset.avgBuyPrice)),
              const SizedBox(width: 12),
              Expanded(child: _buildMetricCard('ROI', selectedAsset.roi, valueColor: const Color(0xFF34C759))),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildMetricCard('Volatility', selectedAsset.volatility)),
              const SizedBox(width: 12),
              Expanded(child: _buildMetricCard('Allocation', selectedAsset.allocation)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, {Color valueColor = Colors.white}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
          color: const Color(0xFF1C1C1E).withValues(alpha: 0.60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.50),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: valueColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
