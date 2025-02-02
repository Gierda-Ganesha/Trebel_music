import 'package:flutter/material.dart';

class ClickCardPage extends StatelessWidget {
  final String cardTitle;
  final String cardSubtitle;
  final String imagePath;

  const ClickCardPage({
    super.key,
    required this.cardTitle,
    required this.cardSubtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    // Debugging print statement
    return Scaffold(
      appBar: AppBar(
        title: Text(cardTitle),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath), // Pastikan path ini valid
              const SizedBox(height: 20),
              Text(
                cardTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              Image.asset(imagePath),
              const SizedBox(height: 20),
              Text(
                cardTitle,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                cardSubtitle,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
