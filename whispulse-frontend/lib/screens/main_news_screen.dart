import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:getnew/screens/news_detail_screen.dart';
import 'package:getnew/services/news/trending_service.dart';
import 'package:getnew/utils/app_colors.dart';
import 'package:getnew/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:url_launcher/url_launcher.dart';

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
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 16,
              top: 8,
              bottom: 8,
            ),
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
          // Category Tabs
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
          SizedBox(height: 20),
          StreamBuilder(
            stream: TrendingService().getTrendingNews(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: GoogleFonts.poppins(color: Colors.red),
                  ),
                );
              }
              if (snapshot.hasData) {
                final data = snapshot.data!.docs;
                if (data.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Data',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: CardSwiper(
                      cardsCount: data.length,
                      numberOfCardsDisplayed: 3,
                      backCardOffset: const Offset(40, 20),
                      padding: const EdgeInsets.all(8),
                      isLoop: true,
                      cardBuilder: (context, index, _, __) {
                        final news = data[index].data();
                        return GestureDetector(
                          onTap: () async {
                            // final url = Uri.parse(news['post_url']);
                            // if (!await launchUrl(url)) {
                            //   throw Exception('Could not launch $url');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDetailScreen(
                                   color:
                                MyColors().cardColors[index %
                                    MyColors().cardColors.length],
                                  title: news['title'] ?? '',
                                  description: news['description'] ?? '',
                                  tag: news['tag'] ?? '',
                                  score: news['score'] ?? '',
                                ),
                              ),
                            );
                            // }
                          },
                          child: _buildNewsCard(
                            color:
                                MyColors().cardColors[index %
                                    MyColors().cardColors.length],
                            title: news['title'] ?? '',
                            description: news['description'] ?? '',
                            tag: news['tag'] ?? '',
                            image: news['image'],
                            score: (news['score'] ?? 0).toDouble(),
                            timestamp: news['timestamp'].toString(),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
              return const Center(
                child: Text('No Data', style: TextStyle(color: Colors.white)),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Builds a single news card widget
  Widget _buildNewsCard({
    required Color color,
    required String title,
    required String description,
    required String tag,
    required String timestamp,
    required double score,
    String? image,
  }) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  tag,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                description,
                style: GoogleFonts.outfit(fontSize: 16, color: Colors.black54),
              ),
            ),
          ),
          const SizedBox(height: 18),
          if (image != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                image,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 18),
          Row(
            children: [
              Icon(
                score >= 0 ? Icons.trending_up : Icons.trending_down,
                color: score >= 0 ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 8),
              Text(
                score.toString(),
                style: GoogleFonts.outfit(
                  color: score >= 0 ? Colors.green : Colors.red,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
