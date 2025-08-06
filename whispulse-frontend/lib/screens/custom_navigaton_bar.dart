import 'package:flutter/material.dart';
import 'package:getnew/utils/app_colors.dart';
import 'package:getnew/screens/main_news_screen.dart';
import 'package:getnew/screens/news_detail_screen.dart';
import 'package:getnew/screens/saved_news_screen.dart';
import 'package:hugeicons/hugeicons.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;

  // Your different screens/pages
  final List<Widget> _pages = [
    MainNewsScreen(),
    // NewsDetailScreen(title: title, description: description, tag: tag, score: score),
    Placeholder(),
    SavedNewsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content - takes full screen
          _pages[_currentIndex],

          // Floating navigation bar
          Positioned(
            bottom: 30, // Distance from bottom
            left: 100, // Distance from left
            right: 100, // Distance from right
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.darkgrey, // Semi-transparent
                borderRadius: BorderRadius.circular(60),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavButton(HugeIcons.strokeRoundedHome02, 0),
                  _buildNavButton(HugeIcons.strokeRoundedSearch01, 1),
                  _buildNavButton(HugeIcons.strokeRoundedBookmark02, 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(IconData icon, int index) {
    bool isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppColors.white : AppColors.lightgrey,
        ),
        child: Icon(
          icon,
          color: isSelected ? AppColors.black : AppColors.white,
          size: isSelected ? 24 : 24,
        ),
      ),
    );
  }
}
