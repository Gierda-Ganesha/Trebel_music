import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:music/features/home/presentation/pages/home_page.dart';
import 'package:music/features/home/presentation/provider/recent_cards_provider.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
=======
import 'package:music/features/home/presentation/providers/recent_cards_provider.dart';
import 'package:provider/provider.dart';
import 'package:music/features/home/presentation/pages/home_page.dart';
>>>>>>> 95caeaca3a0e5e98764abfa8108d4bb2fc36bd39

void main() {
  Logger.level = Level.debug;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecentCardsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      title: 'Music App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
=======
      home: HomePage(),
>>>>>>> 95caeaca3a0e5e98764abfa8108d4bb2fc36bd39
    );
  }
}
