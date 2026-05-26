import 'package:flutter/material.dart';
import 'screens/content_view.dart';

class SiyaphilaApp extends StatelessWidget {
  const SiyaphilaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Siyaphila Demo',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xFF7A63FF)),
      home: const ContentView(),
    );
  }
}
