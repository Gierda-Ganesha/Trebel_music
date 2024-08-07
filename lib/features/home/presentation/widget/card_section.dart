import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:music/features/home/presentation/pages/see_more.dart';
import 'package:music/features/home/presentation/provider/recent_cards_provider.dart';
import 'package:music/features/home/presentation/widget/click_card.dart';
import 'package:music/features/home/presentation/widget/custom_card.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
=======
import 'package:music/features/home/presentation/widget/click_card.dart';
import 'custom_card.dart';
import 'package:music/features/home/presentation/pages/see_more_page.dart';
import 'package:music/features/home/presentation/providers/recent_cards_provider.dart';
import 'package:provider/provider.dart';
>>>>>>> 95caeaca3a0e5e98764abfa8108d4bb2fc36bd39

class CardSection extends StatelessWidget {
  final String sectionTitle;
  final List<Map<String, String>> titles;

  const CardSection({
    super.key,
    required this.sectionTitle,
    required this.titles,
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    var logger = Logger();
=======
>>>>>>> 95caeaca3a0e5e98764abfa8108d4bb2fc36bd39
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionTitle,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SeeMorePage()),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Text(
                    'See More',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffB3C8CF),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: titles.length,
              itemBuilder: (context, index) {
                final cardData = titles[index];
                return CustomCard(
                  cardTitle: cardData['title']!,
                  cardSubtitle: cardData['subtitle']!,
                  imagePath: cardData['image']!,
                  onTap: () {
<<<<<<< HEAD
                    logger.d(
                        'Navigating to ClickCardPage with data: $cardData'); // Logging statement
                    Provider.of<RecentCardsProvider>(context, listen: false)
                        .addCard(cardData);
=======
                    Provider.of<RecentCardsProvider>(context, listen: false)
                        .addRecentCard(cardData); // Debugging
>>>>>>> 95caeaca3a0e5e98764abfa8108d4bb2fc36bd39
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClickCardPage(
                          cardTitle: cardData['title']!,
                          cardSubtitle: cardData['subtitle']!,
                          imagePath: cardData['image']!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
