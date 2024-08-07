import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black, // Hitam solid
            Colors.black.withOpacity(0.8), // Hitam dengan opacity 0.8
            Colors.black.withOpacity(0.6), // Hitam dengan opacity 0.6
            Colors.transparent, // Transparan
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      padding: const EdgeInsets.only(
          top: 4), // Menambahkan padding untuk efek gradient lebih baik
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent, // Menghilangkan efek splash
          highlightColor: Colors.transparent, // Menghilangkan efek highlight
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green, // Warna teks saat item dipilih
          unselectedItemColor:
              Colors.white, // Warna teks saat item tidak dipilih
          selectedLabelStyle:
              const TextStyle(fontSize: 14.0), // Ukuran teks saat dipilih
          unselectedLabelStyle:
              const TextStyle(fontSize: 14.0), // Ukuran teks saat tidak dipilih
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music),
              label: 'Playlist',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Premium',
            ),
          ],
        ),
      ),
    );
  }
}
