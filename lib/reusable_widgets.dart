import 'package:flutter/material.dart';

class NeonButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const NeonButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0ABBAE),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}

class NeonIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;

  const NeonIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 64,
        height: 64,
        decoration: const BoxDecoration(
          color: Color(0xFF1C1C1E),
          shape: BoxShape.circle,
        ),
        child: Center(child: icon),
      ),
    );
  }
}

class NeonInput extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        obscureText: isPassword,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          icon: Icon(icon, color: const Color(0xFF0ABBAE)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
