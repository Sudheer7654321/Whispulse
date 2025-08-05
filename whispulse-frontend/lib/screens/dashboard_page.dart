import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final List<Map<String, dynamic>> topics = [
    {'title': 'ChatGPT Plugin', 'tag': 'Tech', 'score': -3.2},
    {'title': 'Coinbase', 'tag': 'Crypto', 'score': 3.7},
    {'title': 'Minecraft', 'tag': 'YouTube', 'score': -0.8},
    {'title': 'Silver Price', 'tag': 'Stocks', 'score': 1.4},
    {'title': 'Brazil Elections', 'tag': 'World', 'score': -3.2},
  ];

  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhispPulse'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: topics.length,
          itemBuilder: (context, index) {
            final item = topics[index];
            final score = item['score'];
            final isPositive = score > 0;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1D),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  // Tag Pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      item['tag'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Topic Title
                  Expanded(
                    child: Text(
                      item['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  // Score
                  Text(
                    score.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isPositive ? Colors.tealAccent : Colors.redAccent,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
