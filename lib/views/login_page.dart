import 'package:flutter/material.dart';
import 'onboarding_view.dart';
import '../widgets/bottom_nav_wrapper.dart';
import '../widgets/gradient.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0F2027),
                    Color(0xFF203A43),
                    Color(0xFF2C5364),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const OnboardingView()),
                  );
                },
              ),
              title: const Text(
                "Login",
                style: TextStyle(color: Colors.white, fontFamily: 'InterBold'),
              ),
              centerTitle: true,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Masuk ke Akun Anda',
              style: TextStyle(fontSize: 24, fontFamily: 'InterBold'),
            ),
            const SizedBox(height: 30),

            // ===== Input Email =====
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: const TextStyle(fontFamily: 'InterMedium'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                prefixIcon: const Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),

            // ===== Input Password =====
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: const TextStyle(fontFamily: 'InterMedium'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                prefixIcon: const Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 30),

            // ===== Tombol Login Gradasi =====
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const BottomNavWrapper()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: kMainGradient,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'InterSemiBold',
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ===== Lupa Password =====
            TextButton(
              onPressed: () {},
              child: const Text(
                'Lupa Password?',
                style: TextStyle(fontFamily: 'InterMedium'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
