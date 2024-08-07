import 'package:flutter/material.dart';

class SeeMorePage extends StatelessWidget {
  const SeeMorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('See More'),
      ),
      body: const Center(
        child: Text('This is the See More page'),
      ),
    );
  }
}
