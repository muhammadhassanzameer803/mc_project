import 'package:flutter/material.dart';
import 'login_options_page.dart';
import 'dart:async';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      setState(() {
        _currentPage++;
        if (_currentPage >= 2) {
          _currentPage = 0;
        }
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _stopSlider() {
    _timer.cancel();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginOptionsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 149, 149),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ONLINE BLOOD BANK APP',
              style: TextStyle(
                fontFamily: 'Times New Roman',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 175, 26, 15),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: PageView(
                controller: _pageController,
                children: [
                  Image.asset(
                    'assets/heart_logo.png',
                    height: 150,
                  ),
                  Image.asset(
                    'assets/slider 3.png',
                    height: 200,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _stopSlider,
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 175, 26, 15),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              child: const Text(
                'Start',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
