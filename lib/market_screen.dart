import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MarketAsset {
  final String name;
  final String symbol;
  final String price;
  final String change;
  final String logoPath;
  final bool isPositive;
  final List<FlSpot> chartData;
  final String avgBuyPrice;
  final String roi;
  final String volatility;
  final String allocation;

  MarketAsset({
    required this.name,
    required this.symbol,
    required this.price,
    required this.change,
    required this.logoPath,
    required this.isPositive,
    required this.chartData,
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
      name: 'Bitcoin',
      symbol: 'BTC',
      price: '\$64,230.10',
      change: '+3.2%',
      logoPath: 'assets/logos/Bitcoin-Logo.png',
      isPositive: true,
      avgBuyPrice: '\$41,200.50',
      roi: '+11.16%',
      volatility: 'Medium',
      allocation: '34.5%',
      chartData: [
        const FlSpot(0, 62000),
        const FlSpot(1, 63500),
        const FlSpot(2, 63000),
        const FlSpot(3, 64500),
        const FlSpot(4, 63800),
        const FlSpot(5, 65000),
        const FlSpot(6, 64230.10),
      ],
    ),
    MarketAsset(
      name: 'Ethereum',
      symbol: 'ETH',
      price: '\$3,450.25',
      change: '-1.5%',
      logoPath: 'assets/logos/ETH-Logo.png',
      isPositive: false,
      avgBuyPrice: '\$2,100.20',
      roi: '+8.45%',
      volatility: 'High',
      allocation: '22.1%',
      chartData: [
        const FlSpot(0, 3600),
        const FlSpot(1, 3550),
        const FlSpot(2, 3580),
        const FlSpot(3, 3520),
        const FlSpot(4, 3480),
        const FlSpot(5, 3460),
        const FlSpot(6, 3450.25),
      ],
    ),
    MarketAsset(
      name: 'Apple INC',
      symbol: 'AAPL',
      price: '\$185.92',
      change: '+0.8%',
      logoPath: 'assets/logos/Apple-Logo.png',
      isPositive: true,
      avgBuyPrice: '\$150.00',
      roi: '+23.94%',
      volatility: 'Low',
      allocation: '12.4%',
      chartData: [
        const FlSpot(0, 182),
        const FlSpot(1, 183.5),
        const FlSpot(2, 184),
        const FlSpot(3, 183),
        const FlSpot(4, 185),
        const FlSpot(5, 184.8),
        const FlSpot(6, 185.92),
      ],
    ),
  ];

  late MarketAsset selectedAsset;

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
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildCoinSelector(),
                    const SizedBox(height: 24),
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildMainChartCard(),
                    const SizedBox(height: 24),
                    _buildStatsGrid(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCoinSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<MarketAsset>(
          value: selectedAsset,
          dropdownColor: const Color(0xFF1C1C1E),
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF0ABBAE)),
          isExpanded: true,
          onChanged: (MarketAsset? newValue) {
            if (newValue != null) {
              setState(() {
                selectedAsset = newValue;
              });
            }
          },
          items: assets.map<DropdownMenuItem<MarketAsset>>((MarketAsset asset) {
            return DropdownMenuItem<MarketAsset>(
              value: asset,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      asset.logoPath,
                      width: 20,
                      height: 20,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.currency_bitcoin, color: Color(0xFF0ABBAE), size: 20),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    asset.name,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0ABBAE), size: 20),
          ),
        ),
        const SizedBox(width: 16),
        const Text(
          'Price Market',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildMainChartCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedAsset.name,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedAsset.price,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: selectedAsset.isPositive
                      ? Colors.green.withValues(alpha: 0.1)
                      : Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  selectedAsset.change,
                  style: TextStyle(
                    color: selectedAsset.isPositive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 200,
            child: LineChart(
              _buildChartData(),
              duration: const Duration(milliseconds: 250),
            ),
          ),
          const SizedBox(height: 16),
          _buildTimeSelector(),
        ],
      ),
    );
  }

  LineChartData _buildChartData() {
    return LineChartData(
      gridData: const FlGridData(show: false),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 6,
      minY: selectedAsset.chartData.map((e) => e.y).reduce((a, b) => a < b ? a : b) * 0.99,
      maxY: selectedAsset.chartData.map((e) => e.y).reduce((a, b) => a > b ? a : b) * 1.01,
      lineTouchData: LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => const Color(0xFF1C1C1E),
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;
              return LineTooltipItem(
                '\$${flSpot.y.toStringAsFixed(2)}\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: _getDateForIndex(flSpot.x.toInt()),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              );
            }).toList();
          },
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: selectedAsset.chartData,
          isCurved: true,
          color: const Color(0xFF0ABBAE),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                const Color(0xFF0ABBAE).withValues(alpha: 0.3),
                const Color(0xFF0ABBAE).withValues(alpha: 0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }

  String _getDateForIndex(int index) {
    final dates = ['June 06', 'June 07', 'June 08', 'June 09', 'June 10', 'June 11', 'June 12'];
    return dates[index];
  }

  Widget _buildTimeSelector() {
    final periods = ['1H', '1D', '1W', '1M', '1Y', 'ALL'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: periods.map((period) {
        bool isActive = period == '1W';
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF0ABBAE) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            period,
            style: TextStyle(
              color: isActive ? Colors.black : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildStatItem('Avg Buy Price', selectedAsset.avgBuyPrice)),
            const SizedBox(width: 16),
            Expanded(child: _buildStatItem('ROI', selectedAsset.roi, isAccent: true)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildStatItem('Volatility', selectedAsset.volatility)),
            const SizedBox(width: 16),
            Expanded(child: _buildStatItem('Allocation', selectedAsset.allocation)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, {bool isAccent = false}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: isAccent ? const Color(0xFF0ABBAE) : Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
