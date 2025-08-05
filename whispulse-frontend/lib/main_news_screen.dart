import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:getnew/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class MainNewsScreen extends StatefulWidget {
  const MainNewsScreen({super.key});

  @override
  State<MainNewsScreen> createState() => _MainNewsScreenState();
}

class _MainNewsScreenState extends State<MainNewsScreen> {
  final List<String> categories = [
    'Trending',
    'Health',
    'Sports',
    'Finance',
    'Science',
  ];

  final List<Widget> cards = List.generate(
    5,
    (index) => Card(
      color: Colors.grey.shade800,
      child: Center(
        child: Text(
          'Card ${index + 1}',
          style: GoogleFonts.outfit(color: Colors.white, fontSize: 18),
        ),
      ),
    ),
  );

  final customLayoutOption = CustomLayoutOption(startIndex: -1, stateCount: 3)
    ..addTranslate([
      Offset(-300.0, 0.0), // Card at index -1
      Offset(0.0, 0.0), // Card at index 0 (center)
      Offset(300.0, 0.0), // Card at index 1
    ])
    ..addRotate([
      -0.3, // rotate left card
      0.0, // no rotation for center
      0.3, // rotate right card
    ]);

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'WhipPulse',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 16, top: 8, bottom: 8),
            child: CircleAvatar(
              backgroundColor: Colors.black12,
              child: Icon(
                HugeIcons.strokeRoundedNotification02,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Category tabs
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => selectedIndex = index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      child: Text(
                        categories[index],
                        style: GoogleFonts.outfit(
                          color: isSelected
                              ? AppColors.white
                              : Colors.grey[400],
                          fontSize: isSelected ? 22 : 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Flexible(
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return cards[index];
              },
              itemCount: cards.length,
              layout: SwiperLayout.CUSTOM,
              customLayoutOption: customLayoutOption,
              itemWidth: MediaQuery.of(context).size.width * 0.85,
              itemHeight: MediaQuery.of(context).size.height * 0.6,
            ),
          ),
        ],
      ),
    );
  }
}
