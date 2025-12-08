import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final String skinType;
  final double confidence;
  final List<dynamic> recommendations;

  const ResultsScreen({
    super.key,
    required this.skinType,
    required this.confidence,
    required this.recommendations,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECCFA3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFECCFA3),
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Color(0xFF8B5FBF),
        ),
        title: const Text(
          "Results",
          style: TextStyle(
            fontFamily: "Parkinsans",
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8B5FBF),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // MAIN CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    skinType.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: "Parkinsans",
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B5FBF),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Confidence: ${(confidence * 100).toStringAsFixed(2)}%",
                    style: const TextStyle(
                      fontFamily: "Parkinsans",
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Recommendations:",
                    style: TextStyle(
                      fontFamily: "Parkinsans",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...recommendations.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "• $item",
                        style: const TextStyle(
                          fontFamily: "Parkinsans",
                          fontSize: 16,
                          height: 1.3,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // BUTTON
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5FB5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Analyze Another",
                  style: TextStyle(
                    fontFamily: "Parkinsans",
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
