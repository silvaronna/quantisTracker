import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// --- GLASSCARD ---
class GlassCard extends StatelessWidget {
  final Widget child;
  final bool useGradient;
  final EdgeInsetsGeometry padding;

  const GlassCard({
    super.key,
    required this.child,
    this.useGradient = false,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    if (useGradient) {
      return Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [Color(0xFF0ABAB5), Color(0xFF56DFCF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: child,
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: padding,
            color: const Color(0xFF1C1C1E).withValues(alpha: 0.60),
            child: child,
          ),
        ),
      );
    }
  }
}

// --- NEON INPUT ---
class NeonInput extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final Function(String)? onChanged;

  const NeonInput({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.onChanged,
  });

  @override
  State<NeonInput> createState() => _NeonInputState();
}

class _NeonInputState extends State<NeonInput> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _isFocused ? const Color(0xFF2C2C2E) : const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Icon(widget.icon, color: Colors.white.withValues(alpha: 0.50), size: 20),
            ),
            Expanded(
              child: TextField(
                obscureText: widget.isPassword,
                onChanged: widget.onChanged,
                style: const TextStyle(
                  color: Color(0xFFFFEDF3),
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.1,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.30)),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- GRADIENT BUTTON ---
class GradientButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.96),
      onTapUp: (_) {
        setState(() => _scale = 1.0);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 96),
        curve: Curves.easeOutBack,
        child: Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFF0ABAB5),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                letterSpacing: -0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- MICRO SPARKLINE ---
class MicroSparkline extends StatelessWidget {
  final List<double> data;
  final bool isUp;

  const MicroSparkline({
    super.key,
    required this.data,
    required this.isUp,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox(width: 80, height: 40);

    final minData = data.reduce((a, b) => a < b ? a : b);
    final maxData = data.reduce((a, b) => a > b ? a : b);
    final range = maxData - minData;
    
    final minY = minData - (range * 0.1);
    final maxY = maxData + (range * 0.1);

    final spots = data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList();
    final lineColor = isUp ? const Color(0xFF34C759) : const Color(0xFFFF3B30);

    return SizedBox(
      width: 80,
      height: 40,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineTouchData: const LineTouchData(enabled: false),
          minX: 0,
          maxX: (data.length - 1).toDouble(),
          minY: minY,
          maxY: maxY,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: lineColor,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
        duration: Duration.zero, // instant render
      ),
    );
  }
}
