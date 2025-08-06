import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String postUrl;
  final double score;
  final String tag;
  final String? image;

  const NewsCard({
    super.key,
    required this.title,
    required this.description,
    required this.postUrl,
    required this.score,
    required this.tag,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
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
              const Spacer(),
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
          Text(
            description,
            style: GoogleFonts.outfit(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 18),
          // Image (if available)
          if (image != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                image!,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 18),
          // Score + URL
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
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // Open postUrl (you can use url_launcher here)
                },
                child: Text(
                  'View Post',
                  style: GoogleFonts.outfit(
                    color: Colors.blue,
                    fontSize: 15,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
