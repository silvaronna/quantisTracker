import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'reusable_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    // Logo or Icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0ABBAE).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.insights,
                        size: 40,
                        color: Color(0xFF0ABBAE),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Welcome to\nQuantis Track',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Manage your portfolio with precision',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.6),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    // Inputs
                    const NeonInput(
                      hintText: 'Email Address',
                      icon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 16),
                    const NeonInput(
                      hintText: 'Password',
                      icon: Icons.lock_outline,
                      isPassword: true,
                    ),
                    const SizedBox(height: 16),
                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF0ABBAE),
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text('Forgot Password?'),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Login Button
                    NeonButton(
                      label: 'Sign In',
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const DashboardScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    // Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.white.withOpacity(0.1))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.white.withOpacity(0.1))),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Social Login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NeonIconButton(
                          icon: const Icon(Icons.apple, color: Colors.white, size: 28),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 24),
                        NeonIconButton(
                          icon: const Icon(Icons.g_mobiledata, color: Colors.white, size: 32),
                          onPressed: () {},
                        ),
                      ],
                    ),
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
}
