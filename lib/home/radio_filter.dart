import 'package:flutter/material.dart';

class RadioFilterPage extends StatelessWidget {
  const RadioFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radio Filter'),
      ),
      body: const Center(
        child: Text(
          'Halaman Radio Filter',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
