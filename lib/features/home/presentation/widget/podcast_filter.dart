import 'package:flutter/material.dart';

class PodcastFilterPage extends StatelessWidget {
  const PodcastFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Podcast Filter'),
      ),
      body: const Center(
        child: Text(
          'Halaman Podcast Filter',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
