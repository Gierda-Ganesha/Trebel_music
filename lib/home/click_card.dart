import 'package:flutter/material.dart';

class ClickCardPage extends StatelessWidget {
  const ClickCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Details'),
      ),
      body: const Center(
        child: Text(
          'Detail konten dari card yang diklik.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
