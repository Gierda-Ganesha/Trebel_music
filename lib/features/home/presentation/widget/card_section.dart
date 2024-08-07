import 'package:flutter/material.dart';
import 'package:music/features/home/presentation/widget/click_card.dart';
import 'custom_card.dart';
import 'package:music/features/home/presentation/pages/see_more_page.dart';
import 'package:music/features/home/presentation/providers/recent_cards_provider.dart';
import 'package:provider/provider.dart';

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
                    Provider.of<RecentCardsProvider>(context, listen: false)
                        .addRecentCard(cardData); // Debugging
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
