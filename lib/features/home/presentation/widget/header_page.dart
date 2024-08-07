import 'package:flutter/material.dart';
import 'package:music/features/home/presentation/widget/musik_filter.dart';
import 'package:music/features/home/presentation/widget/podcast_filter.dart';
import 'package:music/features/home/presentation/widget/radio_filter.dart';

/// Kelas utama untuk halaman header
class HeaderPage extends StatefulWidget {
  const HeaderPage({super.key});

  @override
  State<HeaderPage> createState() => _HeaderPageState();
}

class _HeaderPageState extends State<HeaderPage> {
  // Variabel untuk menyimpan tombol yang dipilih
  String _selectedButton = 'Semua';

  @override
  void initState() {
    super.initState();
    // Set default tombol ke 'Semua'
    _selectedButton = 'Semua';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.only(left: 16.0), // Menyelaraskan ke kiri
      child: Row(
        children: [
          _buildHeaderButton('Semua', context),
          const SizedBox(width: 8), // Jarak horizontal antar tombol
          _buildHeaderButton('Musik', context),
          const SizedBox(width: 8), // Jarak horizontal antar tombol
          _buildHeaderButton('Podcast', context),
          const SizedBox(width: 8), // Jarak horizontal antar tombol
          _buildHeaderButton('Radio', context),
        ],
      ),
    );
  }

  /// Membuat widget tombol header
  Widget _buildHeaderButton(String title, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          // Set tombol yang dipilih
          _selectedButton = title;
        });
        // Navigasi berdasarkan tombol yang dipilih
        switch (title) {
          case 'Musik':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MusikFilterPage()),
            ).then((_) {
              setState(() {
                // Kembali ke 'Semua' setelah kembali dari halaman lain
                _selectedButton = 'Semua';
              });
            });
            break;
          case 'Podcast':
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PodcastFilterPage()),
            ).then((_) {
              setState(() {
                // Kembali ke 'Semua' setelah kembali dari halaman lain
                _selectedButton = 'Semua';
              });
            });
            break;
          case 'Radio':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RadioFilterPage()),
            ).then((_) {
              setState(() {
                // Kembali ke 'Semua' setelah kembali dari halaman lain
                _selectedButton = 'Semua';
              });
            });
            break;
          default:
            // Handle 'Semua' case
            setState(() {
              // Set tombol yang dipilih ke 'Semua'
              _selectedButton = 'Semua';
            });
            break;
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, // Warna teks tombol
        backgroundColor: _selectedButton == title
            ? Colors.green
            : Colors.grey[800], // Warna latar belakang tombol
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Sudut bulat tombol
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 8.0), // Padding tombol
      ),
      child: Text(title),
    );
  }
}
