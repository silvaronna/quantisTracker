import 'package:flutter/material.dart';
import 'reusable_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Close Button
                IconButton(
                  icon: const Text('X', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  onPressed: () {},
                ),
                const SizedBox(height: 40),
                // Title
                const Text(
                  'Quantis Track',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 12),
                // Description
                Text(
                  'Institutional precision for cross-asset clarity and absolute alpha.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 16,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 48),
                // Form
                const NeonInput(
                  hintText: 'Username or Email',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
                const NeonInput(
                  hintText: 'Password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),
                const SizedBox(height: 24),
                // Remember Me & Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (val) {},
                          fillColor: MaterialStateProperty.all(const Color(0xFF0ABBAE)),
                        ),
                        const Text(
                          'Remember me',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(color: Color(0xFF0ABBAE)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Sign In Button
                NeonButton(
                  label: 'Sign In',
                  onPressed: () {},
                ),
                const SizedBox(height: 32),
                // Secondary Button (e.g. FaceID)
                Center(
                  child: NeonIconButton(
                    icon: const Icon(Icons.face, color: Color(0xFF0ABBAE), size: 32),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
