import 'package:flutter/material.dart';

class MusikFilterPage extends StatelessWidget {
  const MusikFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Musik Filter'),
      ),
      body: const Center(
        child: Text(
          'Halaman Musik Filter',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
