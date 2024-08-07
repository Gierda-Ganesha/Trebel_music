import 'package:flutter/material.dart';
import 'package:music/features/home/presentation/pages/profile_page.dart';
import 'package:music/features/home/presentation/pages/see_more.dart';
import 'package:music/features/home/presentation/provider/recent_cards_provider.dart';
import 'package:music/features/home/presentation/screen/login_page.dart';
import 'package:music/features/home/presentation/pages/see_more_page.dart';
import 'package:music/features/home/presentation/providers/recent_cards_provider.dart';
import 'package:music/features/home/presentation/screen/login_page.dart';
import 'package:music/features/home/presentation/widget/bottom_navigation.dart';
import 'package:music/features/home/presentation/widget/card_section.dart';
import 'package:music/features/home/presentation/widget/card_titles.dart';
import 'package:music/features/home/presentation/widget/click_card.dart';
import 'package:music/features/home/presentation/widget/custom_card.dart';
import 'package:music/features/home/presentation/widget/header_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showPopup = false;
  var logger = Logger();
  String userEmail = '';
  final Set<String> _sectionTitles =
      {}; // Set untuk menyimpan judul seksi yang sudah ditambahkan
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _getUserEmail();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final isFirstLogin = prefs.getBool('isFirstLogin') ?? true;

    if (!isLoggedIn) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    } else if (isLoggedIn && isFirstLogin) {
      setState(() {
        _showPopup = true;
      });
      prefs.setBool('isFirstLogin', false);
      _showPopupMessage();
    }
  }

  Future<void> _getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('userEmail') ?? 'User';
    });
  }

  void _showPopupMessage() {
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        setState(() {
          _showPopup = false;
        });
      }
    });
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 3 && hour < 10) {
      return 'Selamat Pagi';
    } else if (hour >= 10 && hour < 15) {
      return 'Selamat Siang';
    } else if (hour >= 15 && hour < 19) {
      return 'Selamat Sore';
    } else if (hour >= 19 && hour < 23) {
      return 'Selamat Malam';
    } else {
      return 'Selamat Tidur';
    }
  }

  Future<void> _logout(BuildContext context) async {
    logger.d('User logged out');
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.setBool('isFirstLogin', true);

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final greeting = _getGreeting();
  void _addSectionIfNotExist(String title, List<Map<String, String>> titles) {
    if (!_sectionTitles.contains(title)) {
      _sectionTitles.add(title);
      _sections.add(CardSection(sectionTitle: title, titles: titles));
    }
  }

  final List<Widget> _sections = [];

  final List<Widget> _pages = [
    const HomeContent(), // Ini adalah halaman konten Home
    const Center(
        child: Text('Search Page', style: TextStyle(color: Colors.white))),
    const Center(
        child: Text('Playlist Page', style: TextStyle(color: Colors.white))),
    const Center(
        child: Text('Premium Page', style: TextStyle(color: Colors.white))),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 40.0),
              Container(
                color: Colors.black,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      greeting,
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
                              builder: (context) => const ProfilePage()),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.purple,
                        child: Text(
                          userEmail.isNotEmpty
                              ? userEmail[0].toUpperCase()
                              : 'U',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              const HeaderPage(),
              const SizedBox(height: 15.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer<RecentCardsProvider>(
                          builder: (context, recentCardsProvider, child) {
                            return recentCardsProvider.recentCards.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Dengarkan Lagi',
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                logger.d('See More clicked');
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const SeeMorePage()),
                                                );
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.only(
                                                    right: 16.0),
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
                                      ),
                                      const SizedBox(height: 10),
                                      _buildRecentSection(recentCardsProvider),
                                    ],
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                        CardSection(
                            sectionTitle: 'Happy Pagi', titles: pagiTitles),
                        CardSection(
                            sectionTitle: 'Discover more',
                            titles: discoverTitles),
                        CardSection(sectionTitle: 'Galau', titles: galauTitles),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          _buildPopupMessage(),
        ],
      ),
          _pages[_currentIndex],
          _buildPopupMessage(),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }

  Widget _buildPopupMessage() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      top: _showPopup ? 16.0 : -100.0,
      left: 16.0,
      right: 16.0,
      child: AnimatedOpacity(
        opacity: _showPopup ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xff31363F),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            "You're login is successful",
            style: TextStyle(
              color: Colors.white,
              color: Color(0xff31363F),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentSection(RecentCardsProvider recentCardsProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        height: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recentCardsProvider.recentCards.length,
          itemBuilder: (context, index) {
            final cardData = recentCardsProvider.recentCards[index];
            return CustomCard(
              cardTitle: cardData['title']!,
              cardSubtitle: cardData['subtitle']!,
              imagePath: cardData['image']!,
              onTap: () {
                logger.d(
                    'Navigating to ClickCardPage with data: $cardData'); // Logging statement
                Provider.of<RecentCardsProvider>(context, listen: false)
                    .addCard(cardData);
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
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final greeting = _getGreeting();

    return Column(
      children: [
        const SizedBox(height: 40.0),
        Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                greeting,
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
                        builder: (context) => const ProfilePage()),
                  );
                },
                child: const CircleAvatar(
                  child: Text(
                    'K', // Ganti dengan huruf pertama dari nama pengguna
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        const HeaderPage(),
        const SizedBox(height: 15.0),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<RecentCardsProvider>(
                    builder: (context, recentCardsProvider, child) {
                      return recentCardsProvider.recentCards.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Dengarkan Lagi',
                                        style: TextStyle(
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
                                                builder: (context) =>
                                                    const SeeMorePage()),
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
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: SizedBox(
                                    height: 250,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: recentCardsProvider
                                          .recentCards.length,
                                      itemBuilder: (context, index) {
                                        final recentCard = recentCardsProvider
                                            .recentCards[index];
                                        return CustomCard(
                                          cardTitle: recentCard['title'] ?? '',
                                          cardSubtitle:
                                              recentCard['subtitle'] ?? '',
                                          imagePath: recentCard['image'] ?? '',
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ClickCardPage(
                                                  cardTitle:
                                                      recentCard['title'] ?? '',
                                                  cardSubtitle:
                                                      recentCard['subtitle'] ??
                                                          '',
                                                  imagePath:
                                                      recentCard['image'] ?? '',
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                  CardSection(sectionTitle: 'Happy Pagi', titles: pagiTitles),
                  CardSection(
                      sectionTitle: 'Discover more', titles: discoverTitles),
                  CardSection(sectionTitle: 'Galau', titles: galauTitles),
                  CardSection(sectionTitle: 'Mix Song', titles: mixSong),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 3 && hour < 10) {
      return 'Selamat Pagi';
    } else if (hour >= 10 && hour < 15) {
      return 'Selamat Siang';
    } else if (hour >= 15 && hour < 19) {
      return 'Selamat Sore';
    } else if (hour >= 19 && hour < 23) {
      return 'Selamat Malam';
    } else {
      return 'Selamat Tidur';
    }
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', false);
            await prefs.setBool('isFirstLogin', true);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
