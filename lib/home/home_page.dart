import 'package:flutter/material.dart';
import 'package:music/home/see_more_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:music/screen/login_page.dart';
import 'click_card.dart';
import 'package:music/home/header_page.dart';
import 'recent_cards_provider.dart';

/// Kelas utama untuk halaman beranda aplikasi
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/// State untuk HomePage
class _HomePageState extends State<HomePage> {
  // Variabel untuk mengontrol tampilan popup
  bool _showPopup = false;

  @override
  void initState() {
    super.initState();
    // Mengecek status login saat halaman pertama kali dibuka
    _checkLoginStatus();
  }

  /// Mengecek status login pengguna menggunakan SharedPreferences
  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final isFirstLogin = prefs.getBool('isFirstLogin') ?? true;

    // Jika pengguna tidak login, arahkan ke halaman login
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
      // Menandai login pertama kali sudah selesai
      prefs.setBool('isFirstLogin', false);
      // Menampilkan pesan popup
      _showPopupMessage();
    }
  }

  /// Menampilkan pesan popup selama 3 detik
  void _showPopupMessage() {
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        setState(() {
          _showPopup = false;
        });
      }
    });
  }

  /// Mengembalikan salam sesuai dengan waktu saat ini
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat Pagi';
    } else if (hour < 15) {
      return 'Selamat Siang';
    } else if (hour < 18) {
      return 'Selamat Sore';
    } else {
      return 'Selamat Malam';
    }
  }

  /// Fungsi untuk logout dan kembali ke halaman login
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              // Memberikan jarak di bagian atas
              const SizedBox(height: 40.0),
              // Kontainer untuk menampilkan salam dan tombol logout
              Container(
                color: Colors.black,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0), // Menambahkan jarak vertikal
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Menampilkan salam
                    Text(
                      greeting,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // Tombol logout
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.white),
                      onPressed: _logout,
                    ),
                  ],
                ),
              ),
              // Memberikan jarak antara greeting dan header
              const SizedBox(height: 8.0),
              // Menambahkan HeaderPage
              const HeaderPage(),
              // Memberikan jarak antara header dan konten
              const SizedBox(height: 15.0),
              // Membuat konten dapat di-scroll
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Menampilkan recent cards jika tidak kosong
                        Consumer<RecentCardsProvider>(
                          builder: (context, recentCardsProvider, child) {
                            return recentCardsProvider.recentCards.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Judul untuk bagian recent cards
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
                                                padding: EdgeInsets.only(
                                                    right:
                                                        16.0), // Menambahkan jarak ke kanan
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
                                      // Memberikan jarak antara judul dan kartu
                                      const SizedBox(height: 10),
                                      // Membuat bagian yang menampilkan kartu yang baru saja dilihat
                                      _buildRecentSection(recentCardsProvider),
                                    ],
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                        // Membuat bagian dengan judul dan daftar kartu
                        _buildSection('Happy Pagi', pagiTitles),
                        _buildSection('Discover more', discoverTitles),
                        _buildSection('Galau', galauTitles),
                        _buildSection('Happy Pagi', pagiTitles),
                        _buildSection('Discover more', discoverTitles),
                        _buildSection('Galau', galauTitles),
                        _buildSection('Happy Pagi', pagiTitles),
                        _buildSection('Discover more', discoverTitles),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Menampilkan pesan popup jika diperlukan
          _buildPopupMessage(),
        ],
      ),
    );
  }

  /// Membuat widget untuk menampilkan pesan popup
  Widget _buildPopupMessage() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      top: _showPopup ? 16.0 : -100.0, // Animasi ke atas
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
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  /// Membuat bagian dengan judul dan daftar kartu
  Widget _buildSection(String sectionTitle, List<Map<String, String>> titles) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Menampilkan judul bagian dengan teks "See More"
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
                  padding: EdgeInsets.only(
                      right: 16.0), // Menambahkan jarak ke kanan
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
          // Memberikan jarak antara judul dan kartu
          const SizedBox(height: 20),
          // Membuat list kartu dengan scroll horizontal
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: titles.length,
              itemBuilder: (context, index) {
                return _buildCard(
                  titles[index]['title']!,
                  titles[index]['subtitle']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Membuat bagian untuk menampilkan kartu yang baru saja dilihat
  Widget _buildRecentSection(RecentCardsProvider recentCardsProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        height: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recentCardsProvider.recentCards.length,
          itemBuilder: (context, index) {
            return _buildCard(
              recentCardsProvider.recentCards[index]['title']!,
              recentCardsProvider.recentCards[index]['subtitle']!,
            );
          },
        ),
      ),
    );
  }

  /// Membuat widget kartu dengan judul dan subtitle
  Widget _buildCard(String cardTitle, String cardSubtitle) {
    return GestureDetector(
      onTap: () {
        final recentCardsProvider =
            Provider.of<RecentCardsProvider>(context, listen: false);
        recentCardsProvider
            .addCard({'title': cardTitle, 'subtitle': cardSubtitle});
        // Berpindah ke halaman ClickCardPage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ClickCardPage()),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian gambar dari kartu
            Container(
              width: 160,
              height: 160,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/Bernadya.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Bagian teks dari kartu
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
                  // Menampilkan judul kartu
                  Text(
                    cardTitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // Memberikan jarak antara title dan subtitle
                  const SizedBox(height: 6),
                  // Menampilkan subtitle kartu
                  Text(
                    cardSubtitle,
                    style: const TextStyle(
                      fontSize: 12,
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

// Data untuk judul dan subtitle kartu di bagian 'Happy Pagi'
const List<Map<String, String>> pagiTitles = [
  {
    'title': 'Kopikustik',
    'subtitle': 'dengarkan kumpulan lagu indie untuk mencerahkan hari mu'
  },
  {
    'title': 'Happy Pagi',
    'subtitle':
        'semangatkan pagimu dengan playlist yang membuat harimu semakin menenangkan'
  },
  {
    'title': 'Sarapan Pagi',
    'subtitle':
        'sarapan jangan lupa biar pagimu lebih semangat dan menyenankan dengan senyum di wajahmu'
  },
  {
    'title': 'Feeling good',
    'subtitle':
        'nyam nyam musik enak buatan kita yang bikin pagimu semakin hepii'
  },
  {
    'title': 'Pagi Hari alaKu',
    'subtitle':
        'paling enak dengerin kumpulan lagu keren biar pagimu semakin estetik'
  },
  {
    'title': 'Playlist Anti Mager Pagi',
    'subtitle':
        'playlist paling gokil buat nemenin aktifitas pagimu biar makin Josss!!!'
  },
  {
    'title': 'Dari Kantuk ke Produktif',
    'subtitle':
        'hoaamm masih ngantuk tapi pengen produktif, mending dengerin playlist buat harimu makin happy'
  },
];

// Data untuk judul dan subtitle kartu di bagian 'Discover more'
const List<Map<String, String>> discoverTitles = [
  {
    'title': 'Ekspedisi Irama',
    'subtitle':
        'Biarkan Telingamu Menjelajah Melodi Tersembunyi yang Menanti untuk Ditemukan di Setiap Sudut Dunia Musik'
  },
  {
    'title': 'Melodi Rindu',
    'subtitle':
        'Gali Lebih Dalam dan Temukan Permata Tersembunyi yang Berkilauan di Balik Setiap Lagu, Setiap Genre, Setiap Irama'
  },
  {
    'title': 'Perjalanan Suara',
    'subtitle':
        'Bersiaplah untuk Ekspedisi Melalui Irama yang Tak Terduga, Melodi yang Menginspirasi, dan Harmoni yang Membuka Pintu Menuju Dunia Baru'
  },
  {
    'title': 'Eksplorasi Suara',
    'subtitle':
        'Ikuti Jejak Melodi yang Tersesat dan Temukan Kembali Harmoni yang Terlupakan, Keindahan yang Tersembunyi, dan Keajaiban yang Menanti'
  },
  {
    'title': 'Melodi yang Tersesat',
    'subtitle':
        'Dengarkan Bisikan Melodi dari Masa Depan yang Membuka Pintu Menuju Dunia Baru yang Penuh dengan Kemungkinan Tak Terbatas'
  },
  {
    'title': 'Indie Tersembunyi',
    'subtitle':
        'Pecahkan Kode Rahasia Melodi yang Tersembunyi di Balik Setiap Lagu dan Temukan Makna Tersembunyi yang Menanti untuk Diungkap'
  },
  {
    'title': 'Jazz yang Tak Terduga',
    'subtitle':
        'Dengarkan Harmoni yang Mengalir di Sekitarmu, Irama yang Mengiringi Setiap Langkahmu, dan Melodi yang Mengisi Hidupmu dengan Keindahan'
  },
];

// Data untuk judul dan subtitle kartu di bagian 'Galau'
const List<Map<String, String>> galauTitles = [
  {
    'title': 'Patah Hati Playlist',
    'subtitle': 'Lagu untuk Mengobati Luka dan Merayakan Kebebasan'
  },
  {
    'title': 'Senandung Sendu',
    'subtitle': 'Irama untuk Menemani Kesendirian dan Melamun'
  },
  {
    'title': 'Rindu yang Terpendam',
    'subtitle': 'Irama untuk Mengungkapkan Perasaan yang Tak Terucapkan'
  },
  {
    'title': 'Hujan di Hati',
    'subtitle': 'Lagu untuk Menemani Rintik Hujan dan Kenangan'
  },
  {
    'title': 'Saatnya Move On',
    'subtitle': 'Lagu untuk Melepaskan Masa Lalu dan Membuka Lembaran Baru'
  },
  {
    'title': 'Jeritan Hati',
    'subtitle': 'Lagu untuk Melepaskan Masa Lalu dan Membuka Lembaran Baru'
  },
  {'title': 'Bisikan Rindu', 'subtitle': 'Irama untuk Perasaan yang Terpendam'},
];
