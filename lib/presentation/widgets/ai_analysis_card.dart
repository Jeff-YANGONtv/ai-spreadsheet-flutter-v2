import 'package:flutter/material.dart';

class AiAnalysisCard extends StatelessWidget {
  final String content;

  const AiAnalysisCard({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    if (content.isEmpty) return const SizedBox.shrink();

    return Card(
      color: const Color(0xFF2A2F4A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.cyan.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.auto_awesome, color: Colors.cyan, size: 20),
                SizedBox(width: 8),
                Text('AI Analysis', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(color: Color(0xFFE0E0E0), height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
