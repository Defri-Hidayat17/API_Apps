import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'login_page.dart'; // import login

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // SLIDE
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() => currentIndex = index);
              },
              children: [
                buildSlide1(),
                buildSlide2(),
                buildSlide3(),
                buildSlide4(),
              ],
            ),
          ),

          // INDICATOR BULAT BULAT
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 4,
              effect: const WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: Colors.blue,
              ),
            ),
          ),

          // TOMBOL BAWAH
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child:
                currentIndex != 3
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Skip"),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            if (currentIndex < 3) {
                              _controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
                      ],
                    )
                    : ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        ),
                      ),
                      child: const Text("Get Started"),
                    ),
          ),
        ],
      ),
    );
  }

  // ================= SLIDES ===================

  Widget buildSlide1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircleAvatar(
          radius: 70,
          backgroundImage: AssetImage('assets/images/Defri_pasfoto.png'),
        ),
        SizedBox(height: 20),
        Text(
          'Selamat Datang',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text('Defri Lugas Hidayat', style: TextStyle(fontSize: 15)),
        Text('Universitas Pelita Bangsa', style: TextStyle(fontSize: 15)),
        Text('312310272', style: TextStyle(fontSize: 15)),
        Text('defrilugas46@gmail.com', style: TextStyle(fontSize: 15)),
      ],
    );
  }

  Widget buildSlide2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Image(image: AssetImage('assets/images/logo.png'), width: 200),
        ),
        Text(
          'Selamat Datang di AutoParts',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Kami Menyediakan Berbagai Suku Cadang Untuk Mobil Anda',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget buildSlide3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Image(image: AssetImage('assets/images/parts.png'), width: 200),
        SizedBox(height: 20),
        Text(
          'Spareparts dengan Kualitas terbaik dan Original',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Dapatkan suku cadang dengan harga yang bersaing dan kualitas terbaik',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget buildSlide4() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Image(image: AssetImage('assets/images/cepat.png'), width: 200),
        SizedBox(height: 20),
        Text(
          'Layanan Pengiriman Cepat',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Kami siap mengirimkan suku cadang ke lokasi Anda dengan cepat dan aman',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
