import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Main_01.dart';
import 'Main_02.dart';

class Main extends StatefulWidget {
  @override
  State<Main> createState() => _Main_State();
}

class _Main_State extends State<Main> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToPage(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 2, // 페이지 수
              effect: WormEffect(
                dotColor: Colors.grey,
                activeDotColor: Color(0xff55b150),
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                Main_01(),
                Main_02(),
                // Add more pages if needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
