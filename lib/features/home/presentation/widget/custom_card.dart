import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CustomCard extends StatelessWidget {
  final String cardTitle;
  final String cardSubtitle;
  final String imagePath;
  final VoidCallback onTap;

  const CustomCard({
    super.key,
    required this.cardTitle,
    required this.cardSubtitle,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    return GestureDetector(
      onTap: () {
        logger.d('Card clicked: $cardTitle'); // Logging statement
        onTap();
      },
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 160,
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    cardSubtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff686D76),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
